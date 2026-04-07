import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/app_colors.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../controllers/tugas_guru_controller.dart';

class TugasGuruView extends GetView<TugasGuruController> {
  const TugasGuruView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TugasGuruController());
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Kelola Tugas'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              _showCreateTugasDialog(context);
            },
          ),
        ],
      ),
      body: Obx(
        () =>
            controller.isLoading.value
                ? const LoadingIndicator()
                : RefreshIndicator(
                  onRefresh: controller.loadTugasGuru,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      // Statistik Card
                      _buildStatistikCard(),
                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Daftar Tugas",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${controller.tugasList.length} Tugas",
                            style: TextStyle(
                              color: AppColors.textMedium,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // List Tugas
                      ...controller.tugasList.map((tugas) {
                        return _buildTugasCard(tugas);
                      }).toList(),
                    ],
                  ),
                ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateTugasDialog(context);
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatistikCard() {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Statistik Tugas",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                title: "Total Tugas",
                value: controller.totalTugas.value.toString(),
                color: Colors.blue,
                icon: Icons.assignment,
              ),
              _buildStatItem(
                title: "Berjalan",
                value: controller.tugasBerjalan.value.toString(),
                color: Colors.green,
                icon: Icons.timelapse,
              ),
              _buildStatItem(
                title: "Selesai",
                value: controller.tugasSelesai.value.toString(),
                color: AppColors.success,
                icon: Icons.done_all,
              ),
              _buildStatItem(
                title: "Dikumpulkan",
                value: controller.totalYangMengumpulkan.value.toString(),
                color: Colors.orange,
                icon: Icons.cloud_done,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String title,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          title,
          style: TextStyle(color: AppColors.textMedium, fontSize: 11),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTugasCard(Map<String, dynamic> tugas) {
    final progress = tugas['sudah_kumpul'] / tugas['total_siswa'];
    final statusColor =
        tugas['status'] == 'berjalan' ? Colors.green : AppColors.textMedium;

    return AppCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tugas['title'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${tugas['mapel']} - ${tugas['kelas']}",
                      style: TextStyle(
                        color: AppColors.textMedium,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  tugas['status'] == 'berjalan' ? "Berjalan" : "Selesai",
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Progress Bar
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: AppColors.border,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      progress > 0.7
                          ? Colors.green
                          : progress > 0.3
                          ? Colors.orange
                          : Colors.red,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "${tugas['sudah_kumpul']}/${tugas['total_siswa']}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Deadline: ${tugas['deadline']}",
                style: TextStyle(color: AppColors.textMedium, fontSize: 12),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Icon(
                        Icons.visibility_outlined,
                        color: AppColors.textMedium,
                        size: 18,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Icon(
                        Icons.edit_outlined,
                        color: AppColors.textMedium,
                        size: 18,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      controller.deleteTugas(tugas['id']);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showCreateTugasDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Buat Tugas Baru",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              // Dialog form akan diimplementasikan selanjutnya
              const Text("Form buat tugas akan ditambahkan disini"),
              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }
}
