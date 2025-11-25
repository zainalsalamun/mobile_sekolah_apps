import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/modules/absensi/controller/absensi_controller.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/section_header.dart';
import '../../../config/app_colors.dart';
import '../widgets/absensi_student_item.dart';

class AbsensiView extends GetView<AbsensiController> {
  const AbsensiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Absensi")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER MAPEL + KELAS
            const Text(
              "Kelas: 10 IPA 1",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            const Text(
              "Mata Pelajaran: Matematika",
              style: TextStyle(color: AppColors.textMedium),
            ),
            const SizedBox(height: 6),
            const Text(
              "Tanggal: 12 November 2025",
              style: TextStyle(color: AppColors.textMedium),
            ),

            const SizedBox(height: 20),

            /// LIST SISWA
            const SectionHeader(title: "Daftar Siswa"),
            const SizedBox(height: 12),

            Obx(() {
              return Column(
                children: List.generate(controller.students.length, (index) {
                  final siswa = controller.students[index];

                  return AbsensiStudentItem(
                    nama: siswa["nama"]!,
                    nis: siswa["nis"]!,
                    status: siswa["status"]!,
                    onSelectStatus: (val) {
                      controller.updateStatus(index, val);
                    },
                  );
                }),
              );
            }),

            const SizedBox(height: 24),

            /// TOMBOL SIMPAN
            AppButton(
              text: "Simpan Absensi",
              onPressed: () {
                Get.snackbar(
                  "Berhasil",
                  "Absensi telah disimpan",
                  backgroundColor: AppColors.primary,
                  colorText: Colors.white,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
