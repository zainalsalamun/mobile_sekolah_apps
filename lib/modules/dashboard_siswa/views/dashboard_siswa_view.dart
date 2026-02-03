import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/modules/dashboard_siswa/controller/dashboard_siswa_controller.dart';
import '../../../core/routes/app_routes.dart';
import '../../../config/app_colors.dart';

class DashboardSiswaView extends GetView<DashboardSiswaController> {
  const DashboardSiswaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: Stack(
        children: [
          // Background Gradient Header
          Container(
            height: 320,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                _buildTopBar(),
                const SizedBox(height: 10),
                _buildUserCard(),
                const SizedBox(height: 24),

                // Menu Grid Section
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: _buildMenuGrid(),
                        ),
                      ],
                    ),
                  ),
                ),

                // Spacing for Bottom Bar if needed, but Expanded usually handles it.
                // However, since we have a bottomNavigationBar in Scaffold, the body ends above it.
                const SizedBox(height: 10),
              ],
            ),
          ),

          // Tooltip positioned relative to screen if layout allows,
          // but seeing the design, the tooltip is basically a toast or a specialized widget underneath the button.
          // Since the button is inside the white card now, let's put the tooltip outside or handle it differently.
          // For now, I'll place the tooltip in the stack but make sure it's visible.
          Positioned(
            bottom: 20,
            left: 40,
            right: 40,
            child: IgnorePointer(
              // Just visual
              child: Container(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              // If there is a logo asset, use it. Otherwise Text.
              Icon(Icons.school_rounded, color: Colors.white, size: 28),
              SizedBox(width: 8),
              Text(
                "School App",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Roboto', // Assuming default font or system
                ),
              ),
            ],
          ),
          Row(
            children: [
              // Notification Icon
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.pengumuman),
                child: Obx(
                  () => Stack(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.notifications_none_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      if (controller.unreadNotifCount.value > 0)
                        Positioned(
                          right: 4,
                          top: 4,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              "${controller.unreadNotifCount.value}",
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.setting),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.settings_outlined,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUserCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.5),
                width: 1,
              ),
            ),
            child: const CircleAvatar(
              radius: 28,
              backgroundColor: Colors.white24,
              child: Icon(Icons.person, color: Colors.white, size: 32),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Siswa",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Obx(
                  () => Text(
                    controller.nama.value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          // Points / Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Row(
              children: [
                Icon(Icons.stars_rounded, color: AppColors.primary, size: 18),
                SizedBox(width: 4),
                Text(
                  "100",
                  style: TextStyle(
                    color: AppColors.primary, // Match gradient start
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuGrid() {
    // Defines the grid items locally in the view
    final List<Map<String, dynamic>> menuItems = [
      {
        "title": "Presensi",
        "icon": Icons.access_alarm_rounded,
        "color": const Color(0xFFFF6B6B),
        "route": AppRoutes.absensiSiswa,
      },
      {
        "title": "Jadwal",
        "icon": Icons.import_contacts_rounded,
        "color": const Color(0xFFC0392B),
        "route": AppRoutes.jadwal,
      },
      {
        "title": "Nilai",
        "icon": Icons.assignment_turned_in_rounded,
        "color": const Color(0xFFE84393),
        "route": AppRoutes.nilai,
      },
      {
        "title": "Izin",
        "icon": Icons.mail_outline_rounded,
        "color": const Color(0xFF74B9FF),
        "route": AppRoutes.izin,
      },
      {
        "title": "Artikel",
        "icon": Icons.article_outlined,
        "color": const Color(0xFFE17055),
        "route": null,
      },
      {
        "title": "E-Book",
        "icon": Icons.menu_book_rounded,
        "color": const Color(0xFF0984E3),
        "route": null,
      },
      {
        "title": "Histori",
        "icon": Icons.calendar_today_rounded,
        "color": const Color(0xFF636E72),
        "route": null,
      },
      {
        "title": "Pesan",
        "icon": Icons.chat_bubble_outline_rounded,
        "color": const Color(0xFF00CEC9),
        "route": null,
      },
      {
        "title": "Pulsa & Data",
        "icon": Icons.phonelink_ring_rounded,
        "color": const Color(0xFF2D3436),
        "route": null,
      },
      {
        "title": "Tugasku",
        "icon": Icons.assignment_outlined,
        "color": const Color(0xFFA29BFE),
        "route": null,
      },
      {
        "title": "Kelas Virtual",
        "icon": Icons.monitor_rounded,
        "color": const Color(0xFFFD79A8),
        "route": null,
      },
      {
        "title": "Games",
        "icon": Icons.sports_esports_rounded,
        "color": const Color(0xFFFF7675),
        "route": null,
      },
    ];

    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: menuItems.length,
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.75, // Taller items
        mainAxisSpacing: 16,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return GestureDetector(
          onTap: () {
            if (item["route"] != null) {
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
              // Icon Container
              Container(
                padding: const EdgeInsets.all(
                  10,
                ), // Smaller padding to fit 4 cols
                decoration: BoxDecoration(
                  color: (item['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  item['icon'],
                  color: item['color'],
                  size: 24, // Smaller icon
                ),
              ),
              const SizedBox(height: 8),
              // Text
              Text(
                item['title'],
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11, // Smaller font
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

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline_rounded),
            label: "Pesan",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: "Semua",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: "E-Book",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: "Profil",
          ),
        ],
        onTap: (index) {
          // Navigation logic
          if (index == 4) Get.toNamed(AppRoutes.profile);
          // if (index == 2) Get.toNamed('/all-features'); // example
        },
      ),
    );
  }
}
