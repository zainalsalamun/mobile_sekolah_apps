import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/data/models/absensi_model.dart';
import 'package:mobile_sekolah_apps/data/repositories/absensi_repository.dart';

class AbsensiController extends GetxController {
  final AbsensiRepository _absensiRepository = AbsensiRepository();

  // Student list for guru view
  var students = <Map<String, dynamic>>[
    {"nama": "Dewi", "nis": "2025001", "status": "Hadir"},
    {"nama": "Rama", "nis": "2025002", "status": "Alpha"},
    {"nama": "Lina", "nis": "2025003", "status": "Sakit"},
  ].obs;

  void updateStatus(int index, String newStatus) {
    students[index]["status"] = newStatus;
    students.refresh();
  }

  // History absensi from API
  var historyAbsensi = <AbsensiModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadAbsensiData();
  }

  void loadAbsensiData() async {
    try {
      isLoading.value = true;
      final data = await _absensiRepository.getAbsensi();
      historyAbsensi.value = data;
    } catch (e) {
      debugPrint("Error loading absensi data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Clock In / Out Logic
  var clockInTime = "--:--".obs;
  var clockOutTime = "--:--".obs;
  var isClockedIn = false.obs;
  var todayStatus = "Belum Absen".obs;

  void performClockIn() {
    clockInTime.value = _getCurrentTime();
    isClockedIn.value = true;
    todayStatus.value = "Masuk";

    // Add to history
    historyAbsensi.insert(
      0,
      AbsensiModel(
        tanggal: _getTodayFormatted(),
        status: "Hadir",
        masuk: clockInTime.value,
        pulang: "-",
      ),
    );
  }

  void performClockOut() {
    clockOutTime.value = _getCurrentTime();
    isClockedIn.value = false;
    todayStatus.value = "Pulang";

    if (historyAbsensi.isNotEmpty) {
      // Since AbsensiModel is immutable, create a new one
      var today = historyAbsensi[0];
      historyAbsensi[0] = AbsensiModel(
        tanggal: today.tanggal,
        status: today.status,
        masuk: today.masuk,
        pulang: clockOutTime.value,
        note: today.note,
      );
    }
  }

  void performSakit() {
    todayStatus.value = "Sakit";
    historyAbsensi.insert(
      0,
      AbsensiModel(
        tanggal: _getTodayFormatted(),
        status: "Sakit",
        masuk: "-",
        pulang: "-",
      ),
    );
  }

  void performIzin(String type, String note) {
    todayStatus.value = type;
    historyAbsensi.insert(
      0,
      AbsensiModel(
        tanggal: _getTodayFormatted(),
        status: type,
        masuk: "-",
        pulang: "-",
        note: note,
      ),
    );
  }

  // --- Calendar Logic ---
  var focusedDate = DateTime.now().obs;
  var selectedDate = DateTime.now().obs;

  void changeMonth(int offset) {
    focusedDate.value = DateTime(
      focusedDate.value.year,
      focusedDate.value.month + offset,
    );
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
  }

  // Convert history to map keyed by "yyyy-MM-dd"
  Map<String, AbsensiModel> get eventsByDate {
    Map<String, AbsensiModel> events = {};
    for (var item in historyAbsensi) {
      try {
        DateTime? date = _parseDate(item.tanggal);
        if (date != null) {
          String key = "${date.year}-${date.month}-${date.day}";
          events[key] = item;
        }
      } catch (e) {
        debugPrint("Error parsing date: $e");
      }
    }
    return events;
  }

  DateTime? _parseDate(String? dateStr) {
    if (dateStr == null) return null;
    try {
      var parts = dateStr.split(" ");
      if (parts.length != 3) return null;
      int day = int.parse(parts[0]);
      int year = int.parse(parts[2]);
      int month = _getMonthIndex(parts[1]);
      return DateTime(year, month, day);
    } catch (e) {
      return null;
    }
  }

  int _getMonthIndex(String monthStr) {
    const months = [
      "Jan", "Feb", "Mar", "Apr", "Mei", "Jun",
      "Jul", "Aug", "Sep", "Okt", "Nov", "Des",
    ];
    const monthsEng = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
    ];
    int index = months.indexOf(monthStr);
    if (index == -1) {
      index = monthsEng.indexOf(monthStr);
    }
    return index + 1;
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
  }

  String _getTodayFormatted() {
    final now = DateTime.now();
    const months = [
      "Jan", "Feb", "Mar", "Apr", "Mei", "Jun",
      "Jul", "Agu", "Sep", "Okt", "Nov", "Des",
    ];
    return "${now.day} ${months[now.month - 1]} ${now.year}";
  }
}