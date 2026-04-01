import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/modules/dashboard_guru/controller/dashboard_guru_controller.dart';
import '../../../core/routes/app_routes.dart';
import '../../../config/app_colors.dart';
import '../../../core/widgets/app_card.dart';

class DashboardGuruView extends GetView<DashboardGuruController> {
  const DashboardGuruView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(() {
        return SingleChildScrollView(
          child: Column(
            children: [
              //header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF4A80F0), Color(0xFF6BC7FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Profile
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.white.withOpacity(0.2),
                          child: const Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.nama.value,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              controller.mapel.value,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Notification & Logout
                    Row(
                      children: [
                        Stack(
                          children: [
                            const Icon(
                              Icons.notifications_none_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: () => Get.toNamed(AppRoutes.setting),
                          child: const Icon(
                            Icons.settings_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // Ringkasan Data Siswa
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: AppCard(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.people_alt_rounded,
                              size: 32,
                              color: AppColors.primary,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "${controller.totalSiswa.value}",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                            const Text(
                              "Total Siswa",
                              style: TextStyle(
                                color: AppColors.textMedium,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppCard(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.grade_rounded,
                              size: 32,
                              color: Colors.green,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "${controller.nilaiSudahDiinput.value}",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            const Text(
                              "Nilai Terinput",
                              style: TextStyle(
                                color: AppColors.textMedium,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppCard(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.pending_actions_rounded,
                              size: 32,
                              color: Colors.orange,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "${controller.tugasMenunggu.value}",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                            const Text(
                              "Tugas Pending",
                              style: TextStyle(
                                color: AppColors.textMedium,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 26),

              // Menu Fitur Guru
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Menu Fitur",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 4,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      children: [
                        _buildMenuItem(
                          icon: Icons.grade_rounded,
                          label: "Input Nilai",
                          color: Colors.green,
                          onTap: () => Get.toNamed(AppRoutes.nilai),
                        ),
                        _buildMenuItem(
                          icon: Icons.assignment_turned_in_rounded,
                          label: "Tugas",
                          color: Colors.orange,
                          onTap: () => Get.toNamed(AppRoutes.tugasku),
                        ),
                        _buildMenuItem(
                          icon: Icons.schedule_rounded,
                          label: "Jadwal",
                          color: Colors.blue,
                          onTap: () => Get.toNamed(AppRoutes.jadwal),
                        ),
                        _buildMenuItem(
                          icon: Icons.video_call_rounded,
                          label: "Kelas Virtual",
                          color: Colors.purple,
                          onTap: () => Get.toNamed(AppRoutes.kelasVirtual),
                        ),
                        _buildMenuItem(
                          icon: Icons.group_rounded,
                          label: "Data Siswa",
                          color: Colors.redAccent,
                          onTap: () {},
                        ),
                        _buildMenuItem(
                          icon: Icons.article_rounded,
                          label: "Pengumuman",
                          color: Colors.teal,
                          onTap: () => Get.toNamed(AppRoutes.pengumuman),
                        ),
                        _buildMenuItem(
                          icon: Icons.person_rounded,
                          label: "Profil",
                          color: Colors.indigo,
                          onTap: () => Get.toNamed(AppRoutes.profile),
                        ),
                        _buildMenuItem(
                          icon: Icons.more_horiz_rounded,
                          label: "Lainnya",
                          color: Colors.grey,
                          onTap: () => Get.toNamed(AppRoutes.allFeatures),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 26),

              //jadwal
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Jadwal Mengajar Hari Ini",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),

                    ...controller.jadwalHariIni.map((item) {
                      return AppCard(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.menu_book_outlined,
                                  size: 26,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item["mapel"] ?? "",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      item["kelas"] ?? "",
                                      style: const TextStyle(
                                        color: AppColors.textMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              item["jam"] ?? "",
                              style: const TextStyle(
                                color: AppColors.textMedium,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 26),

              //Pengumuman
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Pengumuman Terbaru",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

                    ...controller.pengumuman.map((item) {
                      return AppCard(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.campaign_rounded,
                                size: 22,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item["judul"] ?? "",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    item["tanggal"] ?? "",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: AppColors.textMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 26, color: color),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
