import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/config/app_colors.dart';
import 'package:mobile_sekolah_apps/modules/izin_siswa/controllers/izin_siswa_controller.dart';

class IzinSiswaView extends GetView<IzinSiswaController> {
  const IzinSiswaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Izin",
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Jenis Izin
            const Text(
              "Jenis Izin",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 12),
            Obx(
              () => Wrap(
                spacing: 12,
                runSpacing: 12,
                children:
                    controller.izinTypes.map((type) {
                      final isSelected = controller.selectedType.value == type;
                      Color activeColor;
                      if (type == "Izin")
                        activeColor = const Color(0xFFFF6B6B);
                      else if (type == "Sakit")
                        activeColor = Colors.orange;
                      else if (type == "Keperluan Sekolah")
                        activeColor = Colors.blue;
                      else
                        activeColor = Colors.grey;

                      // If selected, use the color. If not, use white with border.

                      return GestureDetector(
                        onTap: () => controller.selectType(type),
                        child: Container(
                          width: (Get.width - 52) / 2, // 2 columns with spacing
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: isSelected ? activeColor : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color:
                                  isSelected
                                      ? activeColor
                                      : Colors.grey.shade300,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            type,
                            style: TextStyle(
                              color:
                                  isSelected
                                      ? Colors.white
                                      : AppColors.textMedium,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),

            const SizedBox(height: 24),

            // Section 2: Tanggal Izin
            const Text(
              "Tanggal Izin",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => controller.pickDate(context),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      final date = controller.selectedDate.value;
                      String dateStr = "Pilih Tanggal";
                      if (date != null) {
                        // Simple formatted date without intl
                        final months = [
                          "Januari",
                          "Februari",
                          "Maret",
                          "April",
                          "Mei",
                          "Juni",
                          "Juli",
                          "Agustus",
                          "September",
                          "Oktober",
                          "November",
                          "Desember",
                        ];
                        dateStr =
                            "${date.day} ${months[date.month - 1]} ${date.year}";
                      }

                      return Text(
                        dateStr,
                        style: TextStyle(
                          color:
                              date == null
                                  ? AppColors.textLight
                                  : AppColors.textDark,
                        ),
                      );
                    }),
                    const Icon(
                      Icons.calendar_today_rounded,
                      color: AppColors.textMedium,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Section 3: Keterangan Tambahan
            const Text(
              "Keterangan Tambahan",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: controller.descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: "Deskripsi",
                  hintStyle: TextStyle(color: AppColors.textLight),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Section 4: Upload Gambar
            const Text(
              "Upload Gambar",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: controller.pickImage,
              child: Obx(() {
                if (controller.selectedImage.value != null) {
                  return Stack(
                    children: [
                      Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: FileImage(
                              File(controller.selectedImage.value!),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: GestureDetector(
                          onTap: () => controller.selectedImage.value = null,
                          child: const CircleAvatar(
                            backgroundColor: Colors.black54,
                            radius: 12,
                            child: Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.textLight,
                      style:
                          BorderStyle
                              .solid, // Dash effect needs custom painter, standard border for now or just dashed border logic
                    ),
                  ),
                  // Emulating dashed border with a CustomPaint is better, but simple border is safer for now unless I use a package.
                  // I'll stick to a clean border with dotted/dashed style needs a package like dotted_border.
                  // Since I can't add packages easily without user approval, I'll use a standard border with text/icon.
                  child: CustomPaint(
                    painter: DashedRectPainter(
                      color: AppColors.textLight,
                      strokeWidth: 1.0,
                      gap: 5.0,
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt_rounded,
                            color: AppColors.textDark,
                            size: 24,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Tambah Gambar",
                            style: TextStyle(
                              color: AppColors.textDark,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 40),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: controller.submitIzin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                    0xFF1DD1A1,
                  ), // Cyan/Greenish color from image
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "AJUKAN IZIN",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Simple Dash Painter
class DashedRectPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final double gap;

  DashedRectPainter({
    this.strokeWidth = 1.0,
    this.color = Colors.black,
    this.gap = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint dashedPaint =
        Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;

    double x = size.width;
    double y = size.height;

    Path _topPath = getDashedPath(
      a: const Offset(0, 0),
      b: Offset(x, 0),
      gap: gap,
    );

    Path _rightPath = getDashedPath(a: Offset(x, 0), b: Offset(x, y), gap: gap);

    Path _bottomPath = getDashedPath(
      a: Offset(0, y),
      b: Offset(x, y),
      gap: gap,
    );

    Path _leftPath = getDashedPath(
      a: const Offset(0, 0),
      b: Offset(0, y),
      gap: gap,
    );

    canvas.drawPath(_topPath, dashedPaint);
    canvas.drawPath(_rightPath, dashedPaint);
    canvas.drawPath(_bottomPath, dashedPaint);
    canvas.drawPath(_leftPath, dashedPaint);
  }

  Path getDashedPath({
    required Offset a,
    required Offset b,
    required double gap,
  }) {
    Size size = Size(b.dx - a.dx, b.dy - a.dy);
    Path path = Path();
    path.moveTo(a.dx, a.dy);
    bool shouldDraw = true;

    if (size.width != 0) {
    } else {}

    // Simplification for rect:
    // Just drawing straight lines
    double dist = (a - b).distance;
    double currentDist = 0;

    while (currentDist < dist) {
      double nextDist = currentDist + gap;
      if (nextDist > dist) nextDist = dist;

      double pX = a.dx + (b.dx - a.dx) * (nextDist / dist);
      double pY = a.dy + (b.dy - a.dy) * (nextDist / dist);

      if (shouldDraw) {
        path.lineTo(pX, pY);
      } else {
        path.moveTo(pX, pY);
      }
      shouldDraw = !shouldDraw;
      currentDist = nextDist;
    }
    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
