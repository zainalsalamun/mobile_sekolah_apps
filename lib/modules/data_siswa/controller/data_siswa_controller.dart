import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;

class DataSiswaController extends GetxController {
  RxList<Map<String, dynamic>> siswaList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSiswaData();
  }

  Future<void> fetchSiswaData() async {
    try {
      final String response = await rootBundle.rootBundle.loadString(
        'assets/data/users.json',
      );
      final data = await json.decode(response);
      // Filter only 'siswa' role
      List<Map<String, dynamic>> siswa =
          data
              .where((item) => item['role'] == 'siswa')
              .toList()
              .cast<Map<String, dynamic>>();

      // Map to desired format and assign to siswaList
      siswaList.value = siswa;
    } catch (e) {
      print('Error loading data: $e');
      siswaList.value = [];
    }
  }
}
