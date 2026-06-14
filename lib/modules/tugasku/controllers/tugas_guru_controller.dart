import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/data/models/tugas_model.dart';
import 'package:mobile_sekolah_apps/data/repositories/tugas_repository.dart';

class TugasGuruController extends GetxController {
  final TugasRepository _tugasRepository = TugasRepository();

  final tugasList = <TugasModel>[].obs;
  final isLoading = true.obs;

  final totalTugas = 0.obs;
  final tugasBerjalan = 0.obs;
  final tugasSelesai = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadTugasGuru();
  }

  Future<void> loadTugasGuru() async {
    try {
      isLoading.value = true;
      final data = await _tugasRepository.getTugas();
      tugasList.value = data;

      // Hitung statistik
      totalTugas.value = data.length;
      tugasBerjalan.value =
          data.where((t) => t.status == 'berjalan').length;
      tugasSelesai.value =
          data.where((t) => t.status == 'selesai').length;
    } catch (e) {
      debugPrint("Error loading tugas guru: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Buat tugas baru
  Future<void> createTugas(Map<String, dynamic> newTugas) async {
    try {
      final created = await _tugasRepository.createTugas(newTugas);
      tugasList.insert(0, created);
    } catch (e) {
      debugPrint("Error creating tugas: $e");
    }
  }

  // Edit tugas
  Future<void> editTugas(int id, Map<String, dynamic> updatedData) async {
    try {
      final updated = await _tugasRepository.updateTugas(id, updatedData);
      final index = tugasList.indexWhere((t) => t.id == id);
      if (index != -1) {
        tugasList[index] = updated;
      }
    } catch (e) {
      debugPrint("Error editing tugas: $e");
    }
  }

  // Hapus tugas
  Future<void> deleteTugas(int id) async {
    try {
      await _tugasRepository.deleteTugas(id);
      tugasList.removeWhere((t) => t.id == id);
    } catch (e) {
      debugPrint("Error deleting tugas: $e");
    }
  }
}