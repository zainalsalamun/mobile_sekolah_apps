import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/core/widgets/app_input.dart';
import '../../../config/app_colors.dart';
import '../../../core/widgets/app_button.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailC = TextEditingController();
    final passC = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.school, size: 80, color: AppColors.primary),
            const SizedBox(height: 20),
            const Text(
              "Selamat Datang",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              "Silakan login ke akun Anda",
              style: TextStyle(color: AppColors.textMedium),
            ),

            const SizedBox(height: 40),

            AppInput(
              label: "Email",
              controller: emailC,
              hint: "Masukkan email",
            ),

            const SizedBox(height: 18),

            AppInput(
              label: "Password",
              controller: passC,
              obscure: true,
              hint: "Masukkan password",
            ),

            const SizedBox(height: 30),

            AppButton(
              text: "Login",
              onPressed: () {
                // sementara arahkan ke dashboard siswa
                Get.offAllNamed("/dashboard-siswa");
              },
            ),
          ],
        ),
      ),
    );
  }
}
