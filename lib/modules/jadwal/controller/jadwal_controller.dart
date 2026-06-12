import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/data/models/jadwal_model.dart';
import 'package:mobile_sekolah_apps/data/repositories/dashboard_repository.dart';
import 'package:mobile_sekolah_apps/modules/auth/controller/login_controller.dart';

class JadwalController extends GetxController {
  final DashboardRepository _dashboardRepository = DashboardRepository();
  final LoginController loginC = Get.find<LoginController>();

  final hariList = ["Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu"];

  var selectedHariIndex = 0.obs;
  var allJadwal = <JadwalModel>[].obs;
  var jadwalMingguan = <String, List<JadwalModel>>{}.obs;
  var isLoading = false.obs;

  var focusedDay = DateTime.now().obs;
  var selectedDay = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    loadJadwal();
    selectedDay.value = DateTime.now();
  }

  void loadJadwal() async {
    try {
      isLoading.value = true;
      final data = await _dashboardRepository.getJadwal();
      allJadwal.value = data;

      // Initialize map with empty lists
      final Map<String, List<JadwalModel>> grouping = {};
      for (var hari in hariList) {
        grouping[hari] = [];
      }

      // Filter by guru if role is guru
      final user = loginC.loggedUser.value;
      final isGuru = user?.role == 'guru';
      final namaGuruLogin = user?.name ?? "";

      for (var item in data) {
        if (isGuru && item.guru != namaGuruLogin) continue;

        String hari = item.hari;
        if (grouping.containsKey(hari)) {
          grouping[hari]!.add(item);
        }
      }

      jadwalMingguan.value = grouping;
    } catch (e) {
      debugPrint("Error loading jadwal: $e");
    } finally {
      isLoading.value = false;
    }
  }

  List<JadwalModel> get jadwalHariIni {
    String hari = _getHariFromDate(DateTime.now());
    return jadwalMingguan[hari] ?? [];
  }

  List<JadwalModel> getJadwalForDay(DateTime date) {
    String hari = _getHariFromDate(date);
    return jadwalMingguan[hari] ?? [];
  }

  String _getHariFromDate(DateTime date) {
    int weekday = date.weekday;
    switch (weekday) {
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
