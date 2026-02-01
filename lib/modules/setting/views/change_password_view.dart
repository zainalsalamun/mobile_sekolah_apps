import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/config/app_colors.dart';
import 'package:mobile_sekolah_apps/core/widgets/app_card.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller for input fields
    final oldPassC = TextEditingController();
    final newPassC = TextEditingController();
    final confirmPassC = TextEditingController();

    // RxObs for visibility toggle
    final obscureOld = true.obs;
    final obscureNew = true.obs;
    final obscureConfirm = true.obs;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Ganti Password"),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textDark,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            AppCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Buat Password Baru",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Pastikan password baru anda kuat dan mudah diingat.",
                    style: TextStyle(color: AppColors.textMedium),
                  ),
                  const SizedBox(height: 24),

                  // Old Password
                  _buildPasswordField("Password Lama", oldPassC, obscureOld),
                  const SizedBox(height: 16),

                  // New Password
                  _buildPasswordField("Password Baru", newPassC, obscureNew),
                  const SizedBox(height: 16),

                  // Confirm Password
                  _buildPasswordField(
                    "Konfirmasi Password Baru",
                    confirmPassC,
                    obscureConfirm,
                  ),
                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (oldPassC.text.isEmpty ||
                            newPassC.text.isEmpty ||
                            confirmPassC.text.isEmpty) {
                          Get.snackbar(
                            "Error",
                            "Semua kolom harus diisi",
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                          return;
                        }

                        if (newPassC.text != confirmPassC.text) {
                          Get.snackbar(
                            "Error",
                            "Password baru tidak sama",
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                          return;
                        }

                        Get.back();
                        Get.snackbar(
                          "Sukses",
                          "Password berhasil diubah",
                          backgroundColor: AppColors.success,
                          colorText: Colors.white,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Simpan Password",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField(
    String label,
    TextEditingController controller,
    RxBool obscureText,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        Obx(
          () => TextField(
            controller: controller,
            obscureText: obscureText.value,
            decoration: InputDecoration(
              hintText: "Masukkan $label",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  obscureText.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.grey,
                ),
                onPressed: () => obscureText.toggle(),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
