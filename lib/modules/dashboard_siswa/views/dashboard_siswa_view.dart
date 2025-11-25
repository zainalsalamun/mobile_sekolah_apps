import 'package:flutter/material.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/section_header.dart';
import '../../../config/app_colors.dart';

class DashboardSiswaView extends StatelessWidget {
  const DashboardSiswaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard Siswa")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// GREETING
            Text(
              "Halo, Dewi 👋",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Kelas: 10 IPA 1",
              style: TextStyle(color: AppColors.textMedium),
            ),

            const SizedBox(height: 20),

            /// SUMMARY CARD (ABSENSI BULAN INI)
            const SectionHeader(title: "Ringkasan Absensi"),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: AppCard(
                    child: Column(
                      children: const [
                        Text("Hadir", style: TextStyle(fontSize: 14)),
                        SizedBox(height: 6),
                        Text(
                          "20",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppCard(
                    child: Column(
                      children: const [
                        Text("Izin / Sakit", style: TextStyle(fontSize: 14)),
                        SizedBox(height: 6),
                        Text(
                          "1",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppCard(
                    child: Column(
                      children: const [
                        Text("Alpha", style: TextStyle(fontSize: 14)),
                        SizedBox(height: 6),
                        Text(
                          "1",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// NILAI RATA-RATA
            const SectionHeader(title: "Rata-rata Nilai"),
            const SizedBox(height: 12),
            AppCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Rata-rata Semester Ini",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "84",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// JADWAL HARI INI
            const SectionHeader(title: "Jadwal Hari Ini"),
            const SizedBox(height: 12),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "07:00 - 08:30",
                    style: TextStyle(color: AppColors.textMedium),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Matematika",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Pak Andi",
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
                    "Fisika",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Bu Santi",
                    style: TextStyle(color: AppColors.textMedium),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// PENGUMUMAN
            const SectionHeader(title: "Pengumuman Terbaru"),
            const SizedBox(height: 12),
            AppCard(
              onTap: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Ulangan Umum dimulai Senin",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "12 Nov 2025",
                    style: TextStyle(color: AppColors.textMedium),
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
