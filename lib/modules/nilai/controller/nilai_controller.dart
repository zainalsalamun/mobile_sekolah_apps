import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NilaiController extends GetxController {
  var mapelList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNilai();
  }

  void loadNilai() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/data/nilai_siswa.json',
      );
      final List<dynamic> data = jsonDecode(response);
      mapelList.value = data.cast<Map<String, dynamic>>();
    } catch (e) {
      print("Error loading nilai: $e");
    }
  }

  Map<String, dynamic> getDetailNilai(String mapelName) {
    return mapelList.firstWhere(
      (element) => element['nama'] == mapelName,
      orElse: () => {},
    );
  }
}
