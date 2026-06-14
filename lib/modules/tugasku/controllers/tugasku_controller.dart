import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/data/models/tugas_model.dart';
import 'package:mobile_sekolah_apps/data/repositories/tugas_repository.dart';

class TugaskuController extends GetxController {
  final TugasRepository _tugasRepository = TugasRepository();

  final assignments = <TugasModel>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadAssignments();
  }

  Future<void> loadAssignments() async {
    try {
      isLoading.value = true;
      final data = await _tugasRepository.getTugasku();
      assignments.value = data;
    } catch (e) {
      debugPrint("Error loading assignments: $e");
    } finally {
      isLoading.value = false;
    }
  }
}