import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/config/app_colors.dart';
import 'package:mobile_sekolah_apps/core/widgets/app_card.dart';
import 'package:mobile_sekolah_apps/modules/setting/controller/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          "Pengaturan",
          style: TextStyle(color: AppColors.textDark),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        foregroundColor: AppColors.textDark,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Account Section
            const _SectionHeader(title: "Akun"),
            AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  _SettingItem(
                    icon: Icons.person_outline,
                    title: "Lihat Profil",
                    onTap: () => controller.navigateTo('/profile'),
                  ),
                  const Divider(height: 1),
                  _SettingItem(
                    icon: Icons.lock_outline,
                    title: "Ganti Password",
                    onTap: () => controller.navigateTo('/change-password'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // App Section
            const _SectionHeader(title: "Aplikasi"),
            AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  _SettingItem(
                    icon: Icons.info_outline,
                    title: "Tentang Aplikasi",
                    onTap: () => controller.navigateTo('/about'),
                  ),
                  const Divider(height: 1),
                  _SettingItem(
                    icon: Icons.help_outline,
                    title: "Bantuan & Support",
                    onTap: () => controller.navigateTo('/help'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.logout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade50,
                  foregroundColor: Colors.red,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Keluar Akun",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              "Versi 1.0.0",
              style: TextStyle(color: AppColors.textMedium),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textMedium,
          ),
        ),
      ),
    );
  }
}

class _SettingItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _SettingItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: AppColors.textDark,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}
