import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TugasGuruController extends GetxController {
  final tugasList = <Map<String, dynamic>>[].obs;
  final isLoading = true.obs;

  final totalTugas = 0.obs;
  final tugasBerjalan = 0.obs;
  final tugasSelesai = 0.obs;
  final totalYangMengumpulkan = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadTugasGuru();
  }

  Future<void> loadTugasGuru() async {
    try {
      isLoading.value = true;
      final String response = await rootBundle.loadString(
        'assets/data/tugas_guru.json',
      );
      final List<dynamic> data = json.decode(response);
      tugasList.value = data.cast<Map<String, dynamic>>();

      // Hitung statistik
      totalTugas.value = tugasList.length;
      tugasBerjalan.value =
          tugasList.where((t) => t['status'] == 'berjalan').length;
      tugasSelesai.value =
          tugasList.where((t) => t['status'] == 'selesai').length;
      totalYangMengumpulkan.value = tugasList.fold(
        0,
        (int sum, t) => sum + ((t['sudah_kumpul'] as int?) ?? 0),
      );
    } catch (e) {
      print("Error loading tugas guru: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Buat tugas baru
  Future<void> createTugas(Map<String, dynamic> newTugas) async {
    tugasList.insert(0, {
      ...newTugas,
      'id': DateTime.now().millisecondsSinceEpoch,
      'sudah_kumpul': 0,
      'total_siswa': 36,
      'status': 'berjalan',
      'created_at': DateTime.now().toString(),
    });
  }

  // Edit tugas
  void editTugas(int id, Map<String, dynamic> updatedData) {
    final index = tugasList.indexWhere((t) => t['id'] == id);
    if (index != -1) {
      tugasList[index] = {...tugasList[index], ...updatedData};
    }
  }

  // Hapus tugas
  void deleteTugas(int id) {
    tugasList.removeWhere((t) => t['id'] == id);
  }

  // Lihat daftar siswa yang sudah mengumpulkan
  List<dynamic> getSiswaYangMengumpulkan(int tugasId) {
    final tugas = tugasList.firstWhereOrNull((t) => t['id'] == tugasId);
    if (tugas != null && tugas['siswa_kumpul'] != null) {
      return tugas['siswa_kumpul'];
    }
    return [];
  }

  @override
  void onClose() {
    tugasList.close();
    super.onClose();
  }
}
