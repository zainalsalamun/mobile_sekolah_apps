import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/modules/nilai/controller/nilai_controller.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_badge.dart';
import '../../../config/app_colors.dart';

class NilaiDetailView extends GetView<NilaiController> {
  const NilaiDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final String mapelName = Get.arguments ?? "";

    final List<dynamic> data = controller.detailNilai["data"] as List<dynamic>;

    return Scaffold(
      appBar: AppBar(title: Text("Nilai - $mapelName")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// KKM
            Text(
              "KKM: ${controller.detailNilai["kkm"]}",
              style: const TextStyle(fontSize: 16, color: AppColors.textMedium),
            ),

            const SizedBox(height: 20),

            /// LIST NILAI
            Column(
              children: List.generate(data.length, (index) {
                var item = data[index];

                bool lulus = item["nilai"] >= controller.detailNilai["kkm"];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: AppCard(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// Tipe Penilaian
                        Text(
                          item["tipe"],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        /// Nilai + status
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${item["nilai"]}",
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            lulus
                                ? AppBadge.success("Lulus")
                                : AppBadge.error("Remedial"),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
