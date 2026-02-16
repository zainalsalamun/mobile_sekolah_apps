import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PointController extends GetxController {
  final pointsHistory = <Map<String, dynamic>>[].obs;
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
      final String response = await rootBundle.loadString(
        'assets/data/poin_siswa.json',
      );
      final List<dynamic> data = json.decode(response);
      pointsHistory.value = data.cast<Map<String, dynamic>>();

      // Calculate total points
      int total = 0;
      for (var item in data) {
        total += (item['points'] as int);
      }
      totalPoints.value = total;
    } catch (e) {
      print("Error loading points: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
