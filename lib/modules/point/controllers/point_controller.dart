import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/data/models/poin_model.dart';
import 'package:mobile_sekolah_apps/data/repositories/dashboard_repository.dart';

class PointController extends GetxController {
  final DashboardRepository _dashboardRepository = DashboardRepository();

  final pointsHistory = <PoinModel>[].obs;
  final isLoading = true.obs;
  final totalPoints = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadPoints();
  }

  Future<void> loadPoints() async {
    try {
      isLoading.value = true;
      final data = await _dashboardRepository.getPoin();
      pointsHistory.value = data;

      // Calculate total points
      int total = 0;
      for (var item in data) {
        total += item.points;
      }
      totalPoints.value = total;
    } catch (e) {
      debugPrint("Error loading points: $e");
    } finally {
      isLoading.value = false;
    }
  }
}