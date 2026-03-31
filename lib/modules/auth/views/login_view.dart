import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/core/widgets/app_input.dart';
import 'package:mobile_sekolah_apps/modules/auth/controller/login_controller.dart';
import '../../../config/app_colors.dart';
import '../../../core/widgets/app_button.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailC = TextEditingController();
    final passC = TextEditingController();

    // Default values for testing convenience
    emailC.text = "zainal";
    passC.text = "123";

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
              label: "Username / Email",
              controller: emailC,
              hint: "Masukkan username",
            ),

            const SizedBox(height: 18),

            AppInput(
              label: "Password",
              controller: passC,
              obscure: true,
              hint: "Masukkan password",
            ),

            const SizedBox(height: 20),

            // Pilih Role Login
            Row(
              children: [
                Expanded(
                  child: Obx(
                    () => InkWell(
                      onTap: () => controller.selectedRole.value = "siswa",
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color:
                                controller.selectedRole.value == "siswa"
                                    ? AppColors.primary
                                    : AppColors.border,
                            width: 2,
                          ),
                          color:
                              controller.selectedRole.value == "siswa"
                                  ? AppColors.primary.withOpacity(0.08)
                                  : Colors.transparent,
                        ),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.person_outline,
                              size: 28,
                              color: AppColors.primary,
                            ),
                            SizedBox(height: 6),
                            Text(
                              "Siswa",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: AppColors.textDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Obx(
                    () => InkWell(
                      onTap: () => controller.selectedRole.value = "guru",
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color:
                                controller.selectedRole.value == "guru"
                                    ? AppColors.primary
                                    : AppColors.border,
                            width: 2,
                          ),
                          color:
                              controller.selectedRole.value == "guru"
                                  ? AppColors.primary.withOpacity(0.08)
                                  : Colors.transparent,
                        ),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.supervisor_account_outlined,
                              size: 28,
                              color: AppColors.primary,
                            ),
                            SizedBox(height: 6),
                            Text(
                              "Guru",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: AppColors.textDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            Obx(
              () => AppButton(
                text:
                    "Login sebagai ${controller.selectedRole.value.capitalizeFirst}",
                isLoading: controller.isLoading.value,
                onPressed: () {
                  if (emailC.text.isEmpty || passC.text.isEmpty) {
                    Get.snackbar(
                      "Error",
                      "Username dan Password harus diisi",
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                    return;
                  }
                  controller.login(emailC.text, passC.text);
                },
              ),
            ),

            const SizedBox(height: 20),

            // Hint for testing
            const Text(
              "Hint: siswa1/123 atau guru1/123",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
