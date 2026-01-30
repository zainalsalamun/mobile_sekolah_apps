import 'package:flutter/material.dart';
import 'package:mobile_sekolah_apps/config/app_colors.dart';
import 'package:mobile_sekolah_apps/core/widgets/app_card.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Tentang Aplikasi"),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textDark,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Logo
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                Icons.school_rounded,
                size: 50,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Mobile Sekolah Apps",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Versi 1.0.0",
              style: TextStyle(color: AppColors.textMedium, fontSize: 16),
            ),
            const SizedBox(height: 40),

            // Description
            AppCard(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: const [
                  Text(
                    "Tentang Aplikasi",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Mobile Sekolah Apps adalah platform digital terpadu untuk mempermudah kegiatan akademik di sekolah. Aplikasi ini membantu siswa, guru, dan orang tua dalam memantau absensi, jadwal pelajaran, nilai, dan informasi sekolah lainnya secara real-time.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textDark,
                      height: 1.5,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Credits / Developer
            AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.code, color: AppColors.primary),
                    title: const Text("Pengembang"),
                    subtitle: const Text("Tim IT Sekolah"),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(
                      Icons.email_outlined,
                      color: AppColors.primary,
                    ),
                    title: const Text("Hubungi Kami"),
                    subtitle: const Text("support@sekolah.sch.id"),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(
                      Icons.language,
                      color: AppColors.primary,
                    ),
                    title: const Text("Website"),
                    subtitle: const Text("www.sekolah.sch.id"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
            Text(
              "© 2026 Mobile Sekolah Apps. All rights reserved.",
              style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
