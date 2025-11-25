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
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Jadwal"),
          bottom: const TabBar(
            indicatorColor: AppColors.white,
            labelColor: AppColors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [Tab(text: "Hari Ini"), Tab(text: "Minggu Ini")],
          ),
        ),

        body: TabBarView(
          children: [
            // HALAMAN 1 — Jadwal Hari Ini
            _buildJadwalHariIni(),

            // HALAMAN 2 — Jadwal Minggu Ini
            _buildJadwalMingguan(),
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
        Obx(() {
          return Container(
            height: 55,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.hariList.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                bool active = controller.selectedHariIndex.value == index;

                return GestureDetector(
                  onTap: () => controller.selectedHariIndex.value = index,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: active ? AppColors.primary : AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.primary),
                    ),
                    child: Center(
                      child: Text(
                        controller.hariList[index],
                        style: TextStyle(
                          color: active ? Colors.white : AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }),

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
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
