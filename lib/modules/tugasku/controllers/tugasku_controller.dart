import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TugaskuController extends GetxController {
  final assignments = <Map<String, dynamic>>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadAssignments();
  }

  Future<void> loadAssignments() async {
    try {
      isLoading.value = true;
      final String response = await rootBundle.loadString(
        'assets/data/tugasku.json',
      );
      final List<dynamic> data = json.decode(response);
      assignments.value = data.cast<Map<String, dynamic>>();
    } catch (e) {
      print("Error loading assignments: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
