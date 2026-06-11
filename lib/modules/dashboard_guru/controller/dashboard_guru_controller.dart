import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/data/repositories/dashboard_repository.dart';
import 'package:mobile_sekolah_apps/data/models/jadwal_model.dart';
import 'package:mobile_sekolah_apps/data/models/pengumuman_model.dart';
import 'package:mobile_sekolah_apps/modules/auth/controller/login_controller.dart';

class DashboardGuruController extends GetxController {
  final LoginController _loginController = Get.find<LoginController>();
  final DashboardRepository _dashboardRepository = DashboardRepository();

  var nama = "".obs;
  var mapel = "".obs;
  var isLoading = false.obs;

  var jadwalHariIni = <JadwalModel>[].obs;
  var pengumuman = <PengumumanModel>[].obs;

  var totalSiswa = 0.obs;
  var nilaiSudahDiinput = 0.obs;
  var tugasMenunggu = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadDataGuru();
  }

  void loadDataGuru() async {
    try {
      isLoading.value = true;

      // Get user info
      final user = _loginController.loggedUser.value;
      if (user != null) {
        nama.value = user.name;
        mapel.value = user.jabatan ?? user.role;
      }

      // Load jadwal from API
      final allJadwal = await _dashboardRepository.getJadwal();
      final guruName = nama.value;

      // Filter jadwal for guru's today schedule
      String todayHari = _getHariFromDate(DateTime.now());
      jadwalHariIni.value =
          allJadwal.where((j) => j.hari == todayHari && j.guru == guruName).toList();

      // Load pengumuman from API
      pengumuman.value = await _dashboardRepository.getPengumuman();

      // Stats will be loaded from backend when available
      totalSiswa.value = 126;
      nilaiSudahDiinput.value = 89;
      tugasMenunggu.value = 17;
    } catch (e) {
      debugPrint("Error load data guru: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    Get.offAllNamed('/login');
  }

  String _getHariFromDate(DateTime date) {
    switch (date.weekday) {
      case 1: return "Senin";
      case 2: return "Selasa";
      case 3: return "Rabu";
      case 4: return "Kamis";
      case 5: return "Jumat";
      case 6: return "Sabtu";
      case 7: return "Minggu";
      default: return "Senin";
    }
  }
}