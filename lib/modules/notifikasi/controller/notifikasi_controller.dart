import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../modules/auth/controller/login_controller.dart';

class NotifikasiController extends GetxController {
  final LoginController loginC = Get.find<LoginController>();
  var isLoading = false.obs;
  var daftarNotifikasi = <Map<String, dynamic>>[].obs;
  var unreadCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifikasi();
  }

  Future<void> loadNotifikasi() async {
    try {
      isLoading.value = true;
      final String response = await rootBundle.loadString(
        'assets/data/notifikasi.json',
      );
      final List<dynamic> data = jsonDecode(response);

      // Filter notifikasi yang sesuai role guru
      final isGuru = loginC.loggedUser['role'] == 'guru';

      daftarNotifikasi.value =
          data
              .where((item) {
                final type = item['type'] as String;
                if (isGuru) {
                  // Untuk guru, tampilkan notifikasi yang relevan: izin, absensi, tugas
                  return ['izin', 'absensi', 'tugas', 'umum'].contains(type);
                } else {
                  // Untuk siswa, semua notifikasi
                  return true;
                }
              })
              .map((item) => Map<String, dynamic>.from(item))
              .toList();

      hitungUnread();
    } catch (e) {
      print("Error load notifikasi: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void hitungUnread() {
    unreadCount.value =
        daftarNotifikasi.where((item) => item['isRead'] == false).length;
  }

  void markAsRead(String id) {
    final index = daftarNotifikasi.indexWhere(
      (item) => item['id'].toString() == id,
    );
    if (index != -1) {
      daftarNotifikasi[index]['isRead'] = true;
      daftarNotifikasi.refresh();
      hitungUnread();
    }
  }

  void markAllAsRead() {
    for (var item in daftarNotifikasi) {
      item['isRead'] = true;
    }
    daftarNotifikasi.refresh();
    hitungUnread();
  }
}
