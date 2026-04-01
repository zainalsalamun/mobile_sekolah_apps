import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../../../modules/auth/controller/login_controller.dart';

class DashboardGuruController extends GetxController {
  final LoginController _loginController = Get.find<LoginController>();

  var nama = "".obs;
  var mapel = "".obs;
  var userGuru = <String, dynamic>{}.obs;

  var jadwalHariIni = <Map<String, dynamic>>[].obs;
  var kelasUntukAbsensi = <String, dynamic>{}.obs;
  var pengumuman = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDataGuru();
  }

  void loadDataGuru() async {
    try {
      // Load data user guru
      final String userResponse = await rootBundle.loadString(
        'assets/data/users.json',
      );
      final List<dynamic> users = jsonDecode(userResponse);

      // Dapatkan guru berdasarkan username yang login
      final loggedUser = Get.find<LoginController>().loggedUser.value;

      final guru = users.firstWhere(
        (user) => user['id'] == loggedUser['id'],
        orElse:
            () =>
                users.firstWhere((u) => u['role'] == 'guru', orElse: () => {}),
      );

      if (guru.isNotEmpty) {
        userGuru.value = guru;
        nama.value = guru['name'];
        mapel.value = guru['jabatan'];
      }

      // Load data dashboard guru
      final String dashResponse = await rootBundle.loadString(
        'assets/data/dashboard_guru.json',
      );
      final dashboardData = jsonDecode(dashResponse);

      // Ambil data berdasarkan ID guru yang login
      String guruId = userGuru.value['id'] ?? 'G001';

      if (dashboardData.containsKey(guruId)) {
        jadwalHariIni.value = List<Map<String, dynamic>>.from(
          dashboardData[guruId]['jadwalHariIni'],
        );
        kelasUntukAbsensi.value = Map<String, dynamic>.from(
          dashboardData[guruId]['kelasUntukAbsensi'],
        );
        pengumuman.value = List<Map<String, dynamic>>.from(
          dashboardData[guruId]['pengumuman'],
        );
      }
    } catch (e) {
      print("Error load data guru: $e");
    }
  }

  void logout() {
    Get.offAllNamed('/login');
  }
}
