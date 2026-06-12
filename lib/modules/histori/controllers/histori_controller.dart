import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/data/models/absensi_model.dart';
import 'package:mobile_sekolah_apps/data/models/izin_model.dart';
import 'package:mobile_sekolah_apps/data/repositories/absensi_repository.dart';
import 'package:mobile_sekolah_apps/data/repositories/izin_repository.dart';

class HistoriController extends GetxController {
  final AbsensiRepository _absensiRepository = AbsensiRepository();
  final IzinRepository _izinRepository = IzinRepository();

  final historyAbsensi = <AbsensiModel>[].obs;
  final historyIzin = <IzinModel>[].obs;
  final isLoading = true.obs;

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
      debugPrint("Error loading history data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadAbsensi() async {
    try {
      final data = await _absensiRepository.getAbsensi();
      historyAbsensi.value = data;
    } catch (e) {
      debugPrint("Error loading absensi history: $e");
    }
  }

  Future<void> loadIzin() async {
    try {
      final data = await _izinRepository.getIzin();
      historyIzin.value = data;
    } catch (e) {
      debugPrint("Error loading izin history: $e");
    }
  }
}