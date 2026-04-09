import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class CatatanSiswaController extends GetxController {
  RxList<Map<String, dynamic>> siswaList = <Map<String, dynamic>>[].obs;
  String dataDummy = 'assets/data/users.json';

  @override
  void onInit() {
    super.onInit();
    fetchSiswaData();
  }

  Future<void> fetchSiswaData() async {
    try {
      final String response = await rootBundle.rootBundle.loadString(dataDummy);
      final data = json.decode(response) as List<dynamic>;

      // Filter only 'siswa' role
      List<Map<String, dynamic>> siswa =
          data
              .where((item) => item['role'] == 'siswa')
              .toList()
              .cast<Map<String, dynamic>>();

      // Map to desired format and assign to siswaList
      siswaList.value =
          siswa
              .map(
                (item) => {
                  'id': item['id'],
                  'nama': item['name'],
                  'catatan':
                      item['catatan'] ?? '', // Initialize with empty catatan
                },
              )
              .toList();
    } catch (e) {
      print('Error loading data: $e');
      siswaList.value = [];
    }
  }

  Future<void> saveCatatan(String siswaId, String catatan) async {
    try {
      // Find the index of the siswa in siswaList
      final index = siswaList.indexWhere((element) => element['id'] == siswaId);
      if (index == -1) {
        print('Siswa not found with id: $siswaId');
        return;
      }

      // Update the catatan locally
      siswaList[index]['catatan'] = catatan;

      // Load the JSON data from the file
      final String response = await rootBundle.rootBundle.loadString(dataDummy);
      final List<dynamic> data = json.decode(response);

      // Find the corresponding siswa in the original data and update the catatan
      for (var item in data) {
        if (item['role'] == 'siswa' && item['id'] == siswaId) {
          item['catatan'] = catatan;
          break;
        }
      }

      // Get the application documents directory
      Directory appDocDir =
          await path_provider.getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      final file = File('$appDocPath/users.json');

      // Write the updated data back to the file
      await file.writeAsString(jsonEncode(data));

      print(
        'Catatan saved successfully for siswaId: $siswaId, catatan: $catatan',
      );
    } catch (e) {
      print('Error saving catatan: $e');
    }
  }
}
