import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/modules/pengumuman/controller/pengumuman_controller.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../config/app_colors.dart';

class PengumumanView extends GetView<PengumumanController> {
  const PengumumanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pengumuman")),

      body: Obx(() {
        if (controller.pengumumanList.isEmpty) {
          return const EmptyState(
            title: "Belum Ada Pengumuman",
            subtitle: "Pengumuman baru akan tampil di sini.",
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.pengumumanList.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            var item = controller.pengumumanList[index];

            return AppCard(
              onTap: () => Get.toNamed("/pengumuman-detail", arguments: item),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["judul"]!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item["tanggal"]!,
                    style: const TextStyle(color: AppColors.textMedium),
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
