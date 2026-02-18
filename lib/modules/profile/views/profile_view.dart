import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/modules/profile/controller/profile_controller.dart';
import '../../../config/app_colors.dart';
import '../../../core/widgets/app_card.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          "Profil Siswa",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = controller.studentData;

        return SingleChildScrollView(
          child: Column(
            children: [
              // HEADER PROFILE
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                padding: const EdgeInsets.only(bottom: 40),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white24,
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      data['nama'] ?? "-",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "${data['kelas']} • ${data['nis']}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // DATA SECTIONS
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _buildSectionTitle("Data Pribadi"),
                    AppCard(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _buildInfoRow("NISN", data['nisn']),
                          _buildDivider(),
                          _buildInfoRow(
                            "Tempat, Tgl Lahir",
                            "${data['tempat_lahir']}, ${data['tanggal_lahir']}",
                          ),
                          _buildDivider(),
                          _buildInfoRow("Jenis Kelamin", data['jenis_kelamin']),
                          _buildDivider(),
                          _buildInfoRow("Agama", data['agama']),
                          _buildDivider(),
                          _buildInfoRow("Alamat", data['alamat']),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                    _buildSectionTitle("Kontak"),
                    AppCard(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _buildInfoRow("Email", data['email']),
                          _buildDivider(),
                          _buildInfoRow("No. HP", data['no_hp']),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                    _buildSectionTitle("Data Orang Tua / Wali"),
                    AppCard(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _buildInfoRow("Ayah", data['nama_ayah']),
                          _buildDivider(),
                          _buildInfoRow("Ibu", data['nama_ibu']),
                          _buildDivider(),
                          _buildInfoRow("No. HP Ortu", data['no_hp_orangtua']),
                          _buildDivider(),
                          _buildInfoRow("Wali Kelas", data['wali_kelas']),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
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

  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(color: AppColors.textMedium, fontSize: 14),
            ),
          ),
          Expanded(
            child: Text(
              value ?? "-",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(color: Colors.grey.withOpacity(0.1), height: 16);
  }
}
