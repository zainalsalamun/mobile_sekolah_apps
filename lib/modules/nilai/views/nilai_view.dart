import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/modules/nilai/controller/nilai_controller.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_badge.dart';
import '../../../config/app_colors.dart';

class NilaiView extends GetView<NilaiController> {
  const NilaiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nilai")),

      body: Obx(() {
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.mapelList.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final mapel = controller.mapelList[index] as Map<String, dynamic>;
            bool lulus = mapel["rata"]! >= mapel["kkm"];

            return AppCard(
              onTap:
                  () => Get.toNamed("/nilai-detail", arguments: mapel["nama"]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Nama Mapel
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mapel["nama"],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "KKM: ${mapel["kkm"]}",
                        style: const TextStyle(color: AppColors.textMedium),
                      ),
                    ],
                  ),

                  /// Rata-rata dan status
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${mapel["rata"]}",
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      lulus
                          ? AppBadge.success("Lulus")
                          : AppBadge.error("Tidak Lulus"),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
