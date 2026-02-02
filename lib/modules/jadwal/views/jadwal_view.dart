import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/modules/jadwal/controller/jadwal_controller.dart';
import '../../../config/app_colors.dart';
import '../../../core/widgets/empty_state.dart';
import '../widgets/jadwal_item.dart';

class JadwalView extends GetView<JadwalController> {
  const JadwalView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Jadwal",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: AppColors.primary,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            labelColor: Colors.white,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: "Hari Ini"),
              Tab(text: "Per Hari"),
              Tab(text: "Semua"),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            // HALAMAN 1 — Jadwal Hari Ini
            _buildJadwalHariIni(),

            // HALAMAN 2 — Jadwal Per Hari (Mingguan)
            _buildJadwalMingguan(),

            // HALAMAN 3 — Jadwal Full Seminggu
            _buildJadwalFull(),
          ],
        ),
      ),
    );
  }

  // --- WIDGET 1: JADWAL HARI INI ---
  Widget _buildJadwalHariIni() {
    return Obx(() {
      var list = controller.jadwalHariIni;

      if (list.isEmpty) {
        return const EmptyState(
          title: "Tidak Ada Jadwal",
          subtitle: "Tidak ada mata pelajaran hari ini.",
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: JadwalItem(
              jam: item["jam"]!,
              mapel: item["mapel"]!,
              guru: item["guru"]!,
              kelas: item["kelas"]!,
              icon: item["icon"] ?? "📘",
              tugas: item["tugas"],
            ),
          );
        },
      );
    });
  }

  // --- WIDGET 2: JADWAL MINGGU INI ---
  Widget _buildJadwalMingguan() {
    return Column(
      children: [
        // Selector Hari
        Container(
          height: 70, // Increased height for shadow
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ), // Outer padding
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none, // Allow shadow to flow out
            itemCount: controller.hariList.length,
            separatorBuilder:
                (_, __) => const SizedBox(width: 12), // Cleaner separation
            itemBuilder: (context, index) {
              return Obx(() {
                bool active = controller.selectedHariIndex.value == index;

                return GestureDetector(
                  onTap: () => controller.selectedHariIndex.value = index,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 80, // Fixed width for uniform look
                    decoration: BoxDecoration(
                      color: active ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border:
                          active
                              ? null
                              : Border.all(color: Colors.grey.shade200),
                      boxShadow:
                          active
                              ? [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.4),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                              : [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.05),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                    ),
                    child: Center(
                      child: Text(
                        controller.hariList[index],
                        style: TextStyle(
                          color: active ? Colors.white : AppColors.textMedium,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              });
            },
          ),
        ),

        // LIST JADWAL HARI TERPILIH
        Expanded(
          child: Obx(() {
            final hari =
                controller.hariList[controller.selectedHariIndex.value];
            final list = controller.jadwalMingguan[hari] ?? [];

            if (list.isEmpty) {
              return const EmptyState(
                title: "Tidak Ada Jadwal",
                subtitle: "Belum ada jadwal untuk hari ini.",
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: JadwalItem(
                    jam: item["jam"]!,
                    mapel: item["mapel"]!,
                    guru: item["guru"]!,
                    kelas: item["kelas"]!,
                    icon: item["icon"] ?? "📘",
                    tugas: item["tugas"],
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }

  // --- WIDGET 3: JADWAL FULL SEMUA HARI ---
  Widget _buildJadwalFull() {
    return Obx(() {
      var _ = controller.jadwalMingguan.length;

      if (controller.jadwalMingguan.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      // Use single child scroll view for the whole column content
      // or flatten the list. For simplicity and robustness against overflow:
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children:
              controller.hariList.map((hari) {
                List<Map<String, dynamic>> list =
                    controller.jadwalMingguan[hari] ?? [];
                if (list.isEmpty) return const SizedBox.shrink();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 4,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 4,
                            height: 18,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            hari,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ...list.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: JadwalItem(
                          jam: item["jam"]!,
                          mapel: item["mapel"]!,
                          guru: item["guru"]!,
                          kelas: item["kelas"]!,
                          icon: item["icon"] ?? "📘",
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
        ),
      );
    });
  }
}
