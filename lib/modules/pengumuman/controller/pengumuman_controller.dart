import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PengumumanController extends GetxController {
  var pengumumanList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadPengumumanList();
  }

  void loadPengumumanList() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/data/pengumuman.json',
      );
      final List<dynamic> data = jsonDecode(response);

      // Sort by id descending to show newest first
      data.sort((a, b) => (b['id'] as int).compareTo(a['id'] as int));

      pengumumanList.value = data.cast<Map<String, dynamic>>();
    } catch (e) {
      print("Error loading pengumuman: $e");
    }
  }
}
