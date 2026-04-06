import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class IzinPersetujuanController extends GetxController {
  var isLoading = false.obs;
  var daftarIzinMenunggu = <Map<String, dynamic>>[].obs;
  var daftarIzinRiwayat = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDataIzin();
  }

  void loadDataIzin() async {
    isLoading.value = true;
    try {
      final String response = await rootBundle.loadString(
        'assets/data/izin_siswa.json',
      );
      final data = jsonDecode(response);

      daftarIzinMenunggu.value = List<Map<String, dynamic>>.from(
        data['izin_menunggu'] ?? [],
      );
      daftarIzinRiwayat.value = List<Map<String, dynamic>>.from(
        data['izin_riwayat'] ?? [],
      );
    } catch (e) {
      print("Error load data izin: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void setujuiIzin(String idIzin) {
    final index = daftarIzinMenunggu.indexWhere((item) => item['id'] == idIzin);
    if (index != -1) {
      final izin = daftarIzinMenunggu.removeAt(index);
      izin['status'] = 'Disetujui';
      daftarIzinRiwayat.insert(0, izin);
      Get.snackbar(
        'Berhasil',
        'Izin telah disetujui',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  void tolakIzin(String idIzin, String alasan) {
    final index = daftarIzinMenunggu.indexWhere((item) => item['id'] == idIzin);
    if (index != -1) {
      final izin = daftarIzinMenunggu.removeAt(index);
      izin['status'] = 'Ditolak';
      izin['alasan_tolak'] = alasan;
      daftarIzinRiwayat.insert(0, izin);
      Get.snackbar(
        'Berhasil',
        'Izin telah ditolak',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
