import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/modules/jadwal/controller/jadwal_controller.dart';
import 'package:table_calendar/table_calendar.dart';
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
              Tab(text: "Kalender"),
              Tab(text: "Semua"),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            // HALAMAN 1 — Jadwal Hari Ini
            _buildJadwalHariIni(),

            // HALAMAN 2 — Jadwal Kalender
            _buildJadwalKalender(),

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

  // --- WIDGET 2: JADWAL KALENDER ---
  Widget _buildJadwalKalender() {
    return Column(
      children: [
        // Kalender Section
        Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Obx(
            () => TableCalendar(
              locale: 'id_ID',
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: controller.focusedDay.value,
              currentDay: DateTime.now(),
              calendarFormat:
                  CalendarFormat
                      .week, // Default to Week view for better space validation
              availableCalendarFormats: const {
                CalendarFormat.month: 'Bulanan',
                CalendarFormat.twoWeeks: '2 Minggu',
                CalendarFormat.week: 'Mingguan',
              },
              selectedDayPredicate: (day) {
                return isSameDay(controller.selectedDay.value, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                controller.selectedDay.value = selectedDay;
                controller.focusedDay.value = focusedDay;
              },
              onPageChanged: (focusedDay) {
                controller.focusedDay.value = focusedDay;
              },
              eventLoader: (day) {
                return controller.getJadwalForDay(day);
              },
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                weekendTextStyle: const TextStyle(color: Colors.red),
                holidayTextStyle: const TextStyle(color: Colors.red),
                selectedDecoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                markerDecoration: const BoxDecoration(
                  color: AppColors.warning, // Or another accent color
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: true,
                titleCentered: true,
                formatButtonTextStyle: TextStyle(
                  fontSize: 12,
                  color: AppColors.primary,
                ),
                formatButtonDecoration: BoxDecoration(
                  border: Border.fromBorderSide(
                    BorderSide(color: AppColors.primary),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),
          ),
        ),

        // Selected Date Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Obx(() {
            final date = controller.selectedDay.value;
            // Simple date formatter manually or use intl if preferred, but for now specific format:
            // Let's rely on basic string properties or controller logic if complex.
            // Using a simple custom text for now to avoid intl dependency issues if not initialized
            return Row(
              children: [
                const Icon(
                  Icons.date_range_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  "Jadwal Tanggal ${date.day}/${date.month}/${date.year}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            );
          }),
        ),

        // List Jadwal
        Expanded(
          child: Obx(() {
            final list = controller.getJadwalForDay(
              controller.selectedDay.value,
            );

            if (list.isEmpty) {
              return const EmptyState(
                title: "Tidak Ada Jadwal",
                subtitle: "Tidak ada mata pelajaran pada tanggal ini.",
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
