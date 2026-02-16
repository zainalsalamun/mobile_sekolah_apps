import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HistoriController extends GetxController {
  var historyAbsensi = <Map<String, dynamic>>[].obs;
  var historyIzin = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() async {
    isLoading.value = true;
    try {
      await Future.wait([loadAbsensi(), loadIzin()]);
    } catch (e) {
      print("Error loading history data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadAbsensi() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/data/absensi_siswa.json',
      );
      final List<dynamic> data = jsonDecode(response);
      historyAbsensi.value = data.cast<Map<String, dynamic>>();
    } catch (e) {
      print("Error loading absensi history: $e");
    }
  }

  Future<void> loadIzin() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/data/izin_siswa.json',
      );
      final List<dynamic> data = jsonDecode(response);
      historyIzin.value = data.cast<Map<String, dynamic>>();
    } catch (e) {
      print("Error loading izin history: $e");
    }
  }
}
