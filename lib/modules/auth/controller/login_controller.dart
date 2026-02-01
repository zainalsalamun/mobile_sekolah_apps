import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;

  var emailController = "".obs;
  var passwordController = "".obs;

  Future<void> login(String username, String password) async {
    try {
      isLoading.value = true;

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Load JSON from assets
      final String response = await rootBundle.loadString(
        'assets/data/users.json',
      );
      final List<dynamic> users = jsonDecode(response);

      // Find user
      final user = users.firstWhere(
        (u) => u['username'] == username && u['password'] == password,
        orElse: () => null,
      );

      if (user != null) {
        // Login Success
        Get.snackbar(
          "Berhasil",
          "Selamat datang ${user['name']}",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        if (user['role'] == 'siswa') {
          Get.offAllNamed('/dashboard-siswa');
        } else if (user['role'] == 'guru') {
          Get.offAllNamed('/dashboard-guru');
        }
      } else {
        // Login Failed
        Get.snackbar(
          "Gagal",
          "Username atau password salah",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Terjadi kesalahan: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
