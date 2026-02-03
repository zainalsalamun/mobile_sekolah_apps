import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/app_card.dart';
import '../../../config/app_colors.dart';

class PengumumanDetailView extends StatelessWidget {
  const PengumumanDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Get.arguments ?? {};

    return Scaffold(
      appBar: AppBar(title: const Text("Detail Pengumuman")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: AppCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Judul
              Text(
                data["judul"] ?? '-',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),

              const SizedBox(height: 8),

              // Tanggal
              Text(
                data["tanggal"] ?? '-',
                style: const TextStyle(color: AppColors.textMedium),
              ),

              const SizedBox(height: 16),

              // Isi pengumuman
              Text(
                data["isi"] ?? '-',
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
