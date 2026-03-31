import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NilaiController extends GetxController {
  var fullMapelList = <Map<String, dynamic>>[].obs;
  var filteredMapelList = <Map<String, dynamic>>[].obs;

  final List<String> semesterList = [
    "Semua Semester",
    "Semester 1",
    "Semester 2",
  ];

  RxString selectedSemester = "Semua Semester".obs;

  // User role
  RxBool isGuru = false.obs;
  RxBool showAddButton = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadNilai();
    checkUserRole();
  }

  void checkUserRole() {
    // Simulasi cek role user (nantinya ambil dari auth service)
    // Untuk demo: jika role guru, tampilkan tombol tambah nilai
    isGuru.value = true;
    showAddButton.value = isGuru.value;
  }

  void loadNilai() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/data/nilai_siswa.json',
      );
      final List<dynamic> data = jsonDecode(response);
      fullMapelList.value = data.cast<Map<String, dynamic>>();
      filterNilai();
    } catch (e) {
      print("Error loading nilai: $e");
    }
  }

  void changeSemester(String semester) {
    selectedSemester.value = semester;
    filterNilai();
  }

  void filterNilai() {
    if (selectedSemester.value == "Semua Semester") {
      filteredMapelList.value = List.from(fullMapelList);
      return;
    }

    int semesterNumber = int.parse(selectedSemester.value.split(" ").last);
    filteredMapelList.value =
        fullMapelList.where((item) {
          return item["semester"] == semesterNumber;
        }).toList();
  }

  Map<String, dynamic> getDetailNilai(String mapelName) {
    return filteredMapelList.firstWhere(
      (element) => element['nama'] == mapelName,
      orElse: () => {},
    );
  }

  void addNewNilai(Map<String, dynamic> nilaiBaru) {
    fullMapelList.add(nilaiBaru);
    filterNilai();
  }

  void updateNilai(int index, Map<String, dynamic> nilaiUpdate) {
    fullMapelList[index] = nilaiUpdate;
    filterNilai();
  }

  void deleteNilai(int index) {
    fullMapelList.removeAt(index);
    filterNilai();
  }
}
