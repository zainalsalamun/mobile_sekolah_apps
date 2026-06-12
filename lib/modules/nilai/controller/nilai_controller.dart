import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/data/models/nilai_model.dart';
import 'package:mobile_sekolah_apps/data/repositories/nilai_repository.dart';

class NilaiController extends GetxController {
  final NilaiRepository _nilaiRepository = NilaiRepository();

  var fullMapelList = <NilaiModel>[].obs;
  var filteredMapelList = <NilaiModel>[].obs;
  var isLoading = false.obs;

  final List<String> semesterList = [
    "Semua Semester",
    "Semester 1",
    "Semester 2",
  ];

  RxString selectedSemester = "Semua Semester".obs;

  RxBool isGuru = false.obs;
  RxBool showAddButton = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadNilai();
    checkUserRole();
  }

  void checkUserRole() {
    // TODO: Ambil dari auth service / token
    isGuru.value = true;
    showAddButton.value = isGuru.value;
  }

  void loadNilai() async {
    try {
      isLoading.value = true;
      final data = await _nilaiRepository.getNilai();
      fullMapelList.value = data;
      filterNilai();
    } catch (e) {
      debugPrint("Error loading nilai: $e");
    } finally {
      isLoading.value = false;
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
        fullMapelList.where((item) => item.semester == semesterNumber).toList();
  }

  NilaiModel? getDetailNilai(String mapelName) {
    try {
      return filteredMapelList.firstWhere(
        (element) => element.nama == mapelName,
      );
    } catch (e) {
      return null;
    }
  }

  void addNewNilai(Map<String, dynamic> data) {
    final newNilai = NilaiModel(
      nama: data["nama"] ?? "",
      rata: data["rata"] ?? 0,
      kkm: data["kkm"] ?? 75,
      semester: data["semester"] ?? 1,
      tugas: [],
      uts: 0,
      uas: 0,
    );
    fullMapelList.add(newNilai);
    filterNilai();
  }
}
