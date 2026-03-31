import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/modules/nilai/controller/nilai_controller.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_badge.dart';
import '../../../config/app_colors.dart';

class NilaiView extends GetView<NilaiController> {
  const NilaiView({super.key});

  double get totalRataRata {
    if (controller.filteredMapelList.isEmpty) return 0;
    final total = controller.filteredMapelList.fold<double>(
      0,
      (sum, item) => sum + (item["rata"] as num).toDouble(),
    );
    return total / controller.filteredMapelList.length;
  }

  int get jumlahLulus {
    return controller.filteredMapelList
        .where(
          (item) =>
              (item["rata"] as num).toDouble() >=
              (item["kkm"] as num).toDouble(),
        )
        .length;
  }

  int get jumlahTidakLulus {
    return controller.filteredMapelList.length - jumlahLulus;
  }

  Color getGradeColor(double nilai, double kkm) {
    if (nilai >= kkm + 10) return AppColors.success;
    if (nilai >= kkm) return AppColors.warning;
    return AppColors.error;
  }

  IconData getGradeIcon(double nilai, double kkm) {
    if (nilai >= kkm + 10) return Icons.grade;
    if (nilai >= kkm) return Icons.star_half;
    return Icons.error_outline;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          "Nilai Raport",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textDark,
      ),
      body: Obx(() {
        if (controller.fullMapelList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.filteredMapelList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.assignment_outlined,
                  size: 80,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 16),
                Text(
                  "Belum ada nilai",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Tidak ada data nilai untuk semester ini",
                  style: TextStyle(fontSize: 14, color: Colors.grey[400]),
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        }

        return CustomScrollView(
          slivers: [
            /// ✅ Header Summary Statistik
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, Color(0xFF5D7DF2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      "Rata-rata Keseluruhan",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      totalRataRata.toStringAsFixed(1),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "$jumlahLulus",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "Lulus",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(height: 40, width: 1, color: Colors.white30),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "$jumlahTidakLulus",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "Perlu Perbaikan",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(height: 40, width: 1, color: Colors.white30),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${controller.filteredMapelList.length}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "Total Mapel",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Daftar Mata Pelajaran",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                    Obx(
                      () => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: controller.selectedSemester.value,
                            isDense: true,
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.primary,
                              size: 18,
                            ),
                            items:
                                controller.semesterList.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: AppColors.textDark,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                controller.changeSemester(newValue);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// ✅ List Nilai Mapel
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
              sliver: SliverList.separated(
                itemCount: controller.filteredMapelList.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final mapel = controller.filteredMapelList[index];
                  final nilaiRata = (mapel["rata"] as num).toDouble();
                  final kkm = (mapel["kkm"] as num).toDouble();

                  bool lulus = nilaiRata >= kkm;
                  final gradeColor = getGradeColor(nilaiRata, kkm);
                  final progress = (nilaiRata / 100).clamp(0.0, 1.0);

                  return AppCard(
                    onTap:
                        () => Get.toNamed(
                          "/nilai-detail",
                          arguments: mapel["nama"],
                        ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: gradeColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      getGradeIcon(nilaiRata, kkm),
                                      color: gradeColor,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          mapel["nama"],
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.textDark,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          "KKM Minimum: ${mapel["kkm"]}",
                                          style: const TextStyle(
                                            color: AppColors.textMedium,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${nilaiRata.toInt()}",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: gradeColor,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                lulus
                                    ? AppBadge.success("Lulus")
                                    : AppBadge.error("Remedial"),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        /// ✅ Progress Bar Visual
                        Stack(
                          children: [
                            Container(
                              height: 6,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.border,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            FractionallySizedBox(
                              widthFactor: progress,
                              child: Container(
                                height: 6,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      gradeColor,
                                      gradeColor.withOpacity(0.7),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            Positioned(
                              left:
                                  (kkm / 100) *
                                      MediaQuery.of(context).size.width -
                                  60,
                              top: 10,
                              child: Row(
                                children: [
                                  Container(
                                    width: 2,
                                    height: 16,
                                    color: Colors.redAccent,
                                  ),
                                  const SizedBox(width: 4),
                                  const Text(
                                    "KKM",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "0",
                              style: TextStyle(
                                fontSize: 10,
                                color: AppColors.textLight,
                              ),
                            ),
                            Text(
                              "100",
                              style: TextStyle(
                                fontSize: 10,
                                color: AppColors.textLight,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
