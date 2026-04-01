import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../../../modules/auth/controller/login_controller.dart';

class ProfileController extends GetxController {
  var userData = <String, dynamic>{}.obs;
  // Backward compatibility
  var studentData = <String, dynamic>{}.obs;
  var isLoading = true.obs;
  RxString userRole = "siswa".obs;

  final LoginController _loginController = Get.find<LoginController>();

  @override
  void onInit() {
    super.onInit();
    userRole.value = _loginController.selectedRole.value;
    loadProfileData();
  }

  void loadProfileData() async {
    isLoading.value = true;
    try {
      if (userRole.value == "guru") {
        // Load data guru dari users.json
        final String response = await rootBundle.loadString(
          'assets/data/users.json',
        );
        final List<dynamic> users = jsonDecode(response);

        // Cari user dengan role guru
        final guru = users.firstWhere(
          (user) => user['role'] == 'guru',
          orElse: () => {},
        );

        userData.value = guru;
        studentData.value = guru;
      } else {
        // Load data siswa
        final String response = await rootBundle.loadString(
          'assets/data/profil_siswa_lengkap.json',
        );
        final data = jsonDecode(response);
        userData.value = data;
        studentData.value = data;
      }
    } catch (e) {
      print("Error loading profile data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
