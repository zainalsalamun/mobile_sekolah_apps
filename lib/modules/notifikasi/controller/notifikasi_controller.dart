import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/data/models/notifikasi_model.dart';
import 'package:mobile_sekolah_apps/data/repositories/dashboard_repository.dart';
import 'package:mobile_sekolah_apps/modules/auth/controller/login_controller.dart';

class NotifikasiController extends GetxController {
  final LoginController loginC = Get.find<LoginController>();
  final DashboardRepository _dashboardRepository = DashboardRepository();

  var isLoading = false.obs;
  var daftarNotifikasi = <NotifikasiModel>[].obs;
  var unreadCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifikasi();
  }

  Future<void> loadNotifikasi() async {
    try {
      isLoading.value = true;
      final data = await _dashboardRepository.getNotifikasi();

      // Filter notifikasi berdasarkan role
      final user = loginC.loggedUser.value;
      final isGuru = user?.role == 'guru';

      if (isGuru) {
        daftarNotifikasi.value = data.where((item) {
          return ['izin', 'absensi', 'tugas', 'umum'].contains(item.type);
        }).toList();
      } else {
        daftarNotifikasi.value = data;
      }

      hitungUnread();
    } catch (e) {
      debugPrint("Error load notifikasi: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void hitungUnread() {
    unreadCount.value = daftarNotifikasi.where((item) => !item.isRead).length;
  }

  void markAsRead(int id) {
    final index = daftarNotifikasi.indexWhere((item) => item.id == id);
    if (index != -1) {
      // Create new instance with isRead = true since model is immutable
      var old = daftarNotifikasi[index];
      daftarNotifikasi[index] = NotifikasiModel(
        id: old.id,
        title: old.title,
        message: old.message,
        date: old.date,
        isRead: true,
        type: old.type,
      );
      hitungUnread();
    }
  }

  void markAllAsRead() {
    daftarNotifikasi.value = daftarNotifikasi.map((item) {
      return NotifikasiModel(
        id: item.id,
        title: item.title,
        message: item.message,
        date: item.date,
        isRead: true,
        type: item.type,
      );
    }).toList();
    hitungUnread();
  }
}