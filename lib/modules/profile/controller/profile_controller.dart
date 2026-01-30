import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class ProfileController extends GetxController {
  var studentData = <String, dynamic>{}.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfileData();
  }

  void loadProfileData() async {
    isLoading.value = true;
    try {
      final String response = await rootBundle.loadString(
        'assets/data/profil_siswa_lengkap.json',
      );
      final data = jsonDecode(response);
      studentData.value = data;
    } catch (e) {
      print("Error loading profile data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
