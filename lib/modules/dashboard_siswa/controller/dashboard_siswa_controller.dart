import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/data/models/jadwal_model.dart';
import 'package:mobile_sekolah_apps/data/models/pengumuman_model.dart';
import 'package:mobile_sekolah_apps/data/models/article_model.dart';
import 'package:mobile_sekolah_apps/data/models/notifikasi_model.dart';
import 'package:mobile_sekolah_apps/data/repositories/dashboard_repository.dart';
import 'package:mobile_sekolah_apps/data/repositories/auth_repository.dart';

class DashboardSiswaController extends GetxController {
  final DashboardRepository _dashboardRepository = DashboardRepository();
  final AuthRepository _authRepository = AuthRepository();

  var nama = "Loading...".obs;
  var kelas = "...".obs;
  var statusAbsensi = "...".obs;
  var nilaiRata = 0.obs;

  var jadwalHariIni = <JadwalModel>[].obs;
  var pengumuman = <PengumumanModel>[].obs;
  var articles = <ArticleModel>[].obs;
  var notifikasi = <NotifikasiModel>[].obs;
  var unreadNotifCount = 0.obs;
  var totalPoints = 0.obs;

  var isLoading = false.obs;
  var selectedIndex = 0.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    loadAllData();
  }

  void loadAllData() async {
    isLoading.value = true;
    await Future.wait([
      loadProfile(),
      loadJadwal(),
      loadPengumuman(),
      loadArticles(),
      loadNotifikasi(),
      loadPoints(),
    ]);
    isLoading.value = false;
  }

  Future<void> loadPoints() async {
    try {
      final points = await _dashboardRepository.getPoin();
      int total = 0;
      for (var item in points) {
        total += item.points;
      }
      totalPoints.value = total;
    } catch (e) {
      debugPrint("Error loading points: $e");
    }
  }

  Future<void> loadJadwal() async {
    try {
      final allJadwal = await _dashboardRepository.getJadwal();
      String hariIni = _getHariIni();
      jadwalHariIni.value = allJadwal.where((j) => j.hari == hariIni).toList();
    } catch (e) {
      debugPrint("Error loading jadwal: $e");
    }
  }

  String _getHariIni() {
    int weekday = DateTime.now().weekday;
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

  Future<void> loadProfile() async {
    try {
      final dashboard = await _dashboardRepository.getDashboardSiswa();
      nama.value = dashboard.nama;
      kelas.value = dashboard.kelas;
      statusAbsensi.value = dashboard.statusAbsensi;
      nilaiRata.value = dashboard.nilaiRataRata;
    } catch (e) {
      debugPrint("Error loading profile: $e");
    }
  }

  Future<void> loadPengumuman() async {
    try {
      final data = await _dashboardRepository.getPengumuman();
      pengumuman.value = data;
    } catch (e) {
      debugPrint("Error loading pengumuman: $e");
    }
  }

  Future<void> loadNotifikasi() async {
    try {
      final data = await _dashboardRepository.getNotifikasi();
      notifikasi.value = data;
      unreadNotifCount.value = data.where((n) => !n.isRead).length;
    } catch (e) {
      debugPrint("Error loading notifikasi: $e");
    }
  }

  Future<void> loadArticles() async {
    try {
      final data = await _dashboardRepository.getArticles();
      articles.value = data;
    } catch (e) {
      debugPrint("Error loading articles: $e");
    }
  }

  void logout() async {
    await _authRepository.logout();
    Get.offAllNamed('/login');
  }
}
