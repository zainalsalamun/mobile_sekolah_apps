import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AbsensiController extends GetxController {
  // Dummy data siswa
  var students =
      [
        {"nama": "Dewi", "nis": "2025001", "status": "Hadir"},
        {"nama": "Rama", "nis": "2025002", "status": "Alpha"},
        {"nama": "Lina", "nis": "2025003", "status": "Sakit"},
      ].obs;

  // Update status absensi
  void updateStatus(int index, String newStatus) {
    students[index]["status"] = newStatus;
    students.refresh();
  }

  // Dummy history absensi siswa
  var historyAbsensi = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAbsensiData();
  }

  void loadAbsensiData() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/data/absensi_siswa.json',
      );
      final List<dynamic> data = jsonDecode(response);
      historyAbsensi.value = data.cast<Map<String, dynamic>>();
    } catch (e) {
      print("Error loading absensi data: $e");
    }
  }

  // Clock In / Out Logic
  var clockInTime = "--:--".obs;
  var clockOutTime = "--:--".obs;
  var isClockedIn = false.obs;
  var todayStatus = "Belum Absen".obs; // Belum Absen, Masuk, Pulang

  void performClockIn() {
    // Simulate API call or logic
    clockInTime.value = _getCurrentTime();
    isClockedIn.value = true;
    todayStatus.value = "Masuk";

    // Add to history (mock)
    historyAbsensi.insert(0, {
      "tanggal": "13 Nov 2025", // Dummy 'today'
      "status": "Hadir",
      "masuk": clockInTime.value,
      "pulang": "-",
    });
  }

  void performClockOut() {
    clockOutTime.value = _getCurrentTime();
    isClockedIn.value = false; // Reset toggle but keep status
    todayStatus.value = "Pulang";

    // Update history (mock)
    if (historyAbsensi.isNotEmpty) {
      var today = historyAbsensi[0];
      today["pulang"] = clockOutTime.value;
      historyAbsensi[0] = today; // Trigger refresh
    }
  }

  void performSakit() {
    todayStatus.value = "Sakit";
    historyAbsensi.insert(0, {
      "tanggal": "13 Nov 2025",
      "status": "Sakit",
      "masuk": "-",
      "pulang": "-",
    });
  }

  void performIzin(String type, String note) {
    todayStatus.value = type;
    historyAbsensi.insert(0, {
      "tanggal": "13 Nov 2025",
      "status": type,
      "masuk": "-",
      "pulang": "-",
      "note": note,
    });
  }

  // --- Calendar Logic ---
  var focusedDate = DateTime.now().obs;
  var selectedDate = DateTime.now().obs; // For showing details below calendar

  void changeMonth(int offset) {
    focusedDate.value = DateTime(
      focusedDate.value.year,
      focusedDate.value.month + offset,
    );
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
  }

  // Convert history list to Map<String, dynamic> keyed by "yyyy-MM-dd" for easy lookup
  Map<String, Map<String, dynamic>> get eventsByDate {
    Map<String, Map<String, dynamic>> events = {};
    for (var item in historyAbsensi) {
      if (item['tanggal'] != null) {
        try {
          DateTime? date = _parseDate(item['tanggal']);
          if (date != null) {
            String key = "${date.year}-${date.month}-${date.day}";
            events[key] = item;
          }
        } catch (e) {
          print("Error parsing date: $e");
        }
      }
    }
    return events;
  }

  DateTime? _parseDate(String? dateStr) {
    if (dateStr == null) return null;
    // Format "12 Nov 2025"
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
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "Mei",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Okt",
      "Nov",
      "Des",
    ];
    // Handle English/Indonesian variations if needed, currently assuming exact match or similar
    // Simple lookup
    int index = months.indexOf(monthStr);
    if (index == -1) {
      // Try English fallback
      const monthsEng = [
        "Jan",
        "Feb",
        "Mar",
        "Apr",
        "May",
        "Jun",
        "Jul",
        "Aug",
        "Sep",
        "Oct",
        "Nov",
        "Dec",
      ];
      index = monthsEng.indexOf(monthStr);
    }
    return index + 1; // 1-12
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
  }
}
