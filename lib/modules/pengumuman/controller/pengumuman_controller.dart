import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/data/models/pengumuman_model.dart';
import 'package:mobile_sekolah_apps/data/repositories/dashboard_repository.dart';

class PengumumanController extends GetxController {
  final DashboardRepository _dashboardRepository = DashboardRepository();

  var isLoading = false.obs;
  var pengumumanList = <PengumumanModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadPengumumanList();
  }

  Future<void> loadPengumumanList() async {
    try {
      isLoading.value = true;
      final data = await _dashboardRepository.getPengumuman();

      // Sort by id descending to show newest first
      data.sort((a, b) => b.id.compareTo(a.id));

      pengumumanList.value = data;
    } catch (e) {
      debugPrint("Error loading pengumuman: $e");
    } finally {
      isLoading.value = false;
    }
  }
}