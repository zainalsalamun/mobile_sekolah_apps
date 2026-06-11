import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/data/repositories/auth_repository.dart';
import 'package:mobile_sekolah_apps/data/models/user_model.dart';

class LoginController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  
  var isLoading = false.obs;

  var emailController = "".obs;
  var passwordController = "".obs;

  RxString selectedRole = "siswa".obs;
  Rx<UserModel?> loggedUser = Rx<UserModel?>(null);

  Future<void> login(String username, String password) async {
    try {
      isLoading.value = true;

      final user = await _authRepository.login(username, password);
      loggedUser.value = user;

      Get.snackbar(
        "Berhasil",
        "Selamat datang ${user.name}",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      if (user.role == 'siswa') {
        Get.offAllNamed('/dashboard-siswa');
      } else if (user.role == 'guru') {
        Get.offAllNamed('/dashboard-guru');
      }
    } catch (e) {
      Get.snackbar(
        "Gagal",
        "Username atau password salah",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
