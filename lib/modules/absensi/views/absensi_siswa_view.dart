import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/config/app_colors.dart';
import 'package:mobile_sekolah_apps/core/widgets/app_card.dart';
import 'package:mobile_sekolah_apps/modules/absensi/controller/absensi_controller.dart';

class AbsensiSiswaView extends GetView<AbsensiController> {
  const AbsensiSiswaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Riwayat Absensi"),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textDark,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
        child: Column(
          children: [
            // Clock In Section
            _buildClockInSection(),
            const SizedBox(height: 24),

            // Summary Card
            _buildSummaryCard(),
            const SizedBox(height: 20),

            // History List
            _buildHistoryList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem("Hadir", "12", AppColors.success),
          _buildStatItem("Sakit", "1", Colors.orange),
          _buildStatItem("Alpha", "0", Colors.red),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: AppColors.textMedium),
        ),
      ],
    );
  }

  Widget _buildHistoryList() {
    return Obx(() {
      final focused = controller.focusedDate.value;
      final selected = controller.selectedDate.value;
      final events = controller.eventsByDate;

      // Logic to build calendar grid
      final firstDayOfMonth = DateTime(focused.year, focused.month, 1);
      final lastDayOfMonth = DateTime(focused.year, focused.month + 1, 0);

      // Start form Monday (1)
      final int weekdayOfFirstDay = firstDayOfMonth.weekday;
      final int daysToSkip = weekdayOfFirstDay - 1;

      final int totalDays = lastDayOfMonth.day;
      final int totalGridItems = daysToSkip + totalDays;
      // Ensure we fill row (round up to multiple of 7)
      final int totalCells = (totalGridItems / 7).ceil() * 7;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Month Selector
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => controller.changeMonth(-1),
                icon: const Icon(Icons.chevron_left),
              ),
              Text(
                "${_getMonthName(focused.month)} ${focused.year}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              IconButton(
                onPressed: () => controller.changeMonth(1),
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Days Header (Mon, Tue...)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:
                ["Sen", "Sel", "Rab", "Kam", "Jum", "Sab", "Min"]
                    .map(
                      (d) => SizedBox(
                        width: 40,
                        child: Center(
                          child: Text(
                            d,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textMedium,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
          const SizedBox(height: 8),

          // Calendar Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: totalCells,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1, // Square cells
            ),
            itemBuilder: (context, index) {
              if (index < daysToSkip || index >= daysToSkip + totalDays) {
                return const SizedBox.shrink();
              }

              final int day = index - daysToSkip + 1;
              final DateTime date = DateTime(focused.year, focused.month, day);
              final String key = "${date.year}-${date.month}-${date.day}";

              final event = events[key];

              bool isSelected =
                  selected.year == date.year &&
                  selected.month == date.month &&
                  selected.day == date.day;

              Color? bg;
              Color textCol = AppColors.textDark;

              if (event != null) {
                textCol = Colors.white;
                switch (event['status']) {
                  case 'Hadir':
                    bg = AppColors.success;
                    break;
                  case 'Sakit':
                    bg = Colors.orange;
                    break;
                  case 'Izin':
                    bg = Colors.blue;
                    break;
                  case 'Alpha':
                    bg = Colors.red;
                    break;
                  default:
                    bg = AppColors.textMedium;
                }
              }

              return GestureDetector(
                onTap: () => controller.selectDate(date),
                child: Container(
                  decoration: BoxDecoration(
                    color: bg ?? Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border:
                        isSelected
                            ? Border.all(color: AppColors.primary, width: 2)
                            : null,
                  ),
                  child: Center(
                    child: Text(
                      "$day",
                      style: TextStyle(
                        color: textCol,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),

          // Selected Day Detail
          _buildSelectedDayDetail(selected, events),
        ],
      );
    });
  }

  Widget _buildSelectedDayDetail(
    DateTime selected,
    Map<String, dynamic> events,
  ) {
    String key = "${selected.year}-${selected.month}-${selected.day}";
    var event = events[key];

    // Format display date
    String displayDate =
        "${selected.day} ${_getMonthName(selected.month)} ${selected.year}";

    if (event == null) {
      return Center(
        child: Column(
          children: [
            const Icon(Icons.event_note, size: 48, color: Colors.grey),
            const SizedBox(height: 8),
            Text(
              "Tidak ada data absen pada $displayDate",
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    Color statusColor;
    switch (event['status']) {
      case 'Hadir':
        statusColor = AppColors.success;
        break;
      case 'Sakit':
        statusColor = Colors.orange;
        break;
      case 'Izin':
        statusColor = Colors.blue;
        break;
      case 'Alpha':
        statusColor = Colors.red;
        break;
      default:
        statusColor = AppColors.textMedium;
    }

    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                displayDate,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: statusColor),
                ),
                child: Text(
                  event['status'] ?? "",
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTimeColumn("Masuk", event['masuk'] ?? "-"),
              Container(width: 1, height: 30, color: Colors.grey.shade300),
              _buildTimeColumn("Pulang", event['pulang'] ?? "-"),
            ],
          ),
          if (event['note'] != null) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Catatan: ${event['note']}",
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
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
    return months[month - 1];
  }

  Widget _buildClockInSection() {
    return Obx(() {
      String statusText = "Silahkan absen masuk sekarang";
      String buttonText = "CLOCK IN";
      Color buttonColor = AppColors.primary;
      IconData buttonIcon = Icons.login_rounded;
      VoidCallback? onPressed = controller.performClockIn;

      if (controller.todayStatus.value == "Masuk") {
        statusText = "Jangan lupa absen pulang";
        buttonText = "CLOCK OUT";
        buttonColor = Colors.orange;
        buttonIcon = Icons.logout_rounded;
        onPressed = controller.performClockOut;
      } else if (controller.todayStatus.value == "Pulang") {
        statusText = "Absensi hari ini selesai";
        buttonText = "SELESAI";
        buttonColor = AppColors.success;
        buttonIcon = Icons.check_circle_outline;
        onPressed = null;
      }

      return AppCard(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              "Absensi Hari Ini",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Kamis, 13 Nov 2025",
              style: TextStyle(fontSize: 14, color: AppColors.textMedium),
            ),
            const SizedBox(height: 24),

            // Clock Button
            InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(100),
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors:
                        onPressed == null
                            ? [Colors.grey, Colors.grey]
                            : [buttonColor.withOpacity(0.8), buttonColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: (onPressed == null ? Colors.grey : buttonColor)
                          .withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(buttonIcon, size: 40, color: Colors.white),
                    const SizedBox(height: 10),
                    Text(
                      buttonText,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            if (controller.todayStatus.value == "Belum Absen")
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildActionButton(
                      "Sakit",
                      Icons.sick_outlined,
                      Colors.orange,
                      controller.performSakit,
                    ),
                    const SizedBox(width: 20),
                    _buildActionButton(
                      "Izin",
                      Icons.note_alt_outlined,
                      Colors.blue,
                      () => _showIzinDialog(),
                    ),
                  ],
                ),
              ),

            // Status Info
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 16,
                    color: AppColors.textMedium,
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    "SMK Negeri 1 Jakarta",
                    style: TextStyle(
                      color: AppColors.textMedium,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              statusText,
              style: const TextStyle(color: AppColors.textMedium, fontSize: 14),
            ),

            if (controller.todayStatus.value != "Belum Absen")
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTimeColumn("Masuk", controller.clockInTime.value),
                    Container(
                      height: 30,
                      width: 1,
                      color: Colors.grey.withOpacity(0.3),
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                    ),
                    _buildTimeColumn("Pulang", controller.clockOutTime.value),
                  ],
                ),
              ),
          ],
        ),
      );
    });
  }

  void _showIzinDialog() {
    final TextEditingController noteC = TextEditingController();
    var selectedType = "Izin".obs;

    Get.defaultDialog(
      title: "Form Izin",
      titleStyle: const TextStyle(fontWeight: FontWeight.bold),
      radius: 12,
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Jenis Izin",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildTypeButton(
                    "Izin",
                    selectedType,
                    const Color(0xFFFF6B6B),
                  ),
                  _buildTypeButton("Sakit", selectedType, Colors.orange),
                  _buildTypeButton(
                    "Keperluan Sekolah",
                    selectedType,
                    Colors.blue,
                  ),
                  _buildTypeButton("Lainnya", selectedType, Colors.grey),
                ],
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Keterangan",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: noteC,
                decoration: const InputDecoration(
                  hintText: "Contoh: Urusan Keluarga",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
      textConfirm: "Kirim",
      textCancel: "Batal",
      confirmTextColor: Colors.white,
      buttonColor: AppColors.primary,
      onConfirm: () {
        if (noteC.text.isNotEmpty) {
          controller.performIzin(selectedType.value, noteC.text);
          Get.back(); // Close dialog
        } else {
          Get.snackbar(
            "Error",
            "Keterangan wajib diisi",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      },
    );
  }

  Widget _buildTypeButton(String type, RxString selected, Color color) {
    return Obx(() {
      bool isSelected = selected.value == type;
      return GestureDetector(
        onTap: () => selected.value = type,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? color : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? color : Colors.grey.shade300,
            ),
          ),
          child: Text(
            type,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.textMedium,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      );
    });
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeColumn(String label, String time) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.textMedium),
        ),
        const SizedBox(height: 4),
        Text(
          time,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }
}
