import 'package:flutter/material.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/section_header.dart';
import '../../../config/app_colors.dart';

class DashboardGuruView extends StatelessWidget {
  const DashboardGuruView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard Guru")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// GREETING
            Text(
              "Selamat pagi, Pak Andi 👋",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),
            const Text(
              "Guru Matematika",
              style: TextStyle(color: AppColors.textMedium),
            ),

            const SizedBox(height: 20),

            /// JADWAL HARI INI
            const SectionHeader(title: "Jadwal Hari Ini"),
            const SizedBox(height: 12),

            AppCard(
              onTap: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "07:00 - 08:30",
                    style: TextStyle(color: AppColors.textMedium),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "10 IPA 1",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Matematika",
                    style: TextStyle(color: AppColors.textMedium),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "08:30 - 10:00",
                    style: TextStyle(color: AppColors.textMedium),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "10 IPA 2",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Matematika",
                    style: TextStyle(color: AppColors.textMedium),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// LIST KELAS YANG DIAMPU
            const SectionHeader(title: "Kelas yang Diampu"),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: AppCard(
                    onTap: () {},
                    child: const Center(
                      child: Text("10 IPA 1", style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppCard(
                    onTap: () {},
                    child: const Center(
                      child: Text("10 IPA 2", style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// SHORTCUT ACTION
            const SectionHeader(title: "Aksi Cepat"),
            const SizedBox(height: 12),

            AppCard(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Ambil Absensi",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: AppColors.textMedium,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            AppCard(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Input Nilai",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: AppColors.textMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
