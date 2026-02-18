import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/config/app_colors.dart';
import 'package:mobile_sekolah_apps/config/app_menu.dart';
import '../../dashboard_siswa/controller/dashboard_siswa_controller.dart';
import '../../../core/routes/app_routes.dart';

class AllFeaturesView extends StatelessWidget {
  const AllFeaturesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Semua Fitur",
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.textDark,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Layanan Akademik",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 16),
            _buildGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid() {
    final menuItems = AppMenu.items;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: menuItems.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.75,
        mainAxisSpacing: 20,
        crossAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return GestureDetector(
          onTap: () {
            if (item["route"] != null) {
              if (item["route"] == AppRoutes.ebook) {
                try {
                  final dashboardController =
                      Get.find<DashboardSiswaController>();
                  dashboardController.changeTabIndex(3);
                  return;
                } catch (e) {
                  // Fallback if controller not found
                }
              }
              if (item["route"] == AppRoutes.profile) {
                try {
                  final dashboardController =
                      Get.find<DashboardSiswaController>();
                  dashboardController.changeTabIndex(4);
                  return;
                } catch (e) {
                  // Fallback
                }
              }
              Get.toNamed(item["route"]);
            } else {
              Get.snackbar(
                "Fitur Belum Tersedia",
                "Fitur ${item['title']} sedang dalam pengembangan.",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: const Color(0xFF2D3436),
                colorText: Colors.white,
                borderRadius: 10,
                margin: const EdgeInsets.all(16),
                duration: const Duration(seconds: 2),
              );
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (item['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(item['icon'], color: item['color'], size: 28),
              ),
              const SizedBox(height: 8),
              Text(
                item['title'],
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                  height: 1.2,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
