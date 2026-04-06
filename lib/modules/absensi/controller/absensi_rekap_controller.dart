import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class AbsensiRekapController extends GetxController {
  var isLoading = false.obs;
  var selectedKelas = ''.obs;
  var selectedTanggal = DateTime.now().obs;

  var listKelas = <String>[].obs;
  var rekapAbsensi = <Map<String, dynamic>>[].obs;

  var totalHadir = 0.obs;
  var totalSakit = 0.obs;
  var totalIzin = 0.obs;
  var totalAlpa = 0.obs;
  var totalSiswa = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadDataRekap();
  }

  void loadDataRekap() async {
    isLoading.value = true;
    try {
      final String response = await rootBundle.loadString(
        'assets/data/absensi_siswa.json',
      );
      final data = jsonDecode(response);

      listKelas.value = List<String>.from(data['kelas_tersedia'] ?? []);
      selectedKelas.value = listKelas.isNotEmpty ? listKelas.first : '';

      rekapAbsensi.value = List<Map<String, dynamic>>.from(
        data['rekap_per_siswa'] ?? [],
      );

      hitungStatistik();
    } catch (e) {
      print("Error load rekap absensi: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void hitungStatistik() {
    totalHadir.value = rekapAbsensi.where((s) => s['status'] == 'Hadir').length;
    totalSakit.value = rekapAbsensi.where((s) => s['status'] == 'Sakit').length;
    totalIzin.value = rekapAbsensi.where((s) => s['status'] == 'Izin').length;
    totalAlpa.value = rekapAbsensi.where((s) => s['status'] == 'Alpa').length;
    totalSiswa.value = rekapAbsensi.length;
  }

  void filterByKelas(String kelas) {
    selectedKelas.value = kelas;
    loadDataRekap();
  }

  void ubahTanggal(DateTime tanggal) {
    selectedTanggal.value = tanggal;
    loadDataRekap();
  }

  double getPersentaseHadir() {
    if (totalSiswa.value == 0) return 0;
    return (totalHadir.value / totalSiswa.value) * 100;
  }
}
