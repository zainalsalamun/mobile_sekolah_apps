import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../modules/auth/controller/login_controller.dart';

class JadwalController extends GetxController {
  final LoginController loginC = Get.find<LoginController>();
  // Hari dalam seminggu
  final hariList = ["Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu"];

  // Index tab hari
  var selectedHariIndex = 0.obs;

  // Dummy Jadwal Mingguan
  var jadwalMingguan = <String, List<Map<String, dynamic>>>{}.obs;

  // Calendar States
  var focusedDay = DateTime.now().obs;
  var selectedDay = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    loadJadwal();
    // Set initial selected day to today
    selectedDay.value = DateTime.now();
  }

  void loadJadwal() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/data/jadwal_siswa.json',
      );
      final List<dynamic> data = jsonDecode(response);

      // Initialize map with empty lists
      final Map<String, List<Map<String, dynamic>>> grouping = {};
      for (var hari in hariList) {
        grouping[hari] = [];
      }

      // Jika user adalah guru, hanya tampilkan jadwal yang dia ampu
      final isGuru = loginC.loggedUser['role'] == 'guru';
      final namaGuruLogin = loginC.loggedUser['name']?.toString() ?? "";

      for (var item in data) {
        // Filter hanya jadwal guru yang login jika role adalah guru
        if (isGuru) {
          final namaGuruJadwal = item['guru']?.toString() ?? "";
          if (namaGuruJadwal != namaGuruLogin) continue;
        }

        String hari = item['hari'] ?? "Senin";
        if (grouping.containsKey(hari)) {
          grouping[hari]!.add({
            "jam": item['jam'].toString(),
            "mapel": item['mapel'].toString(),
            "guru": item['guru']?.toString() ?? "-",
            "kelas": item['kelas']?.toString() ?? "-",
            "icon": item['icon']?.toString() ?? "📘",
            "tugas": item['tugas']?.toString(), // Nullable
          });
        }
      }

      jadwalMingguan.value = grouping;
    } catch (e) {
      print("Error loading jadwal: $e");
    }
  }

  // Jadwal hari ini based on real day
  List<Map<String, dynamic>> get jadwalHariIni {
    String hari = _getHariFromDate(DateTime.now());
    return jadwalMingguan[hari] ?? [];
  }

  // Get jadwal for the selected day in calendar
  List<Map<String, dynamic>> getJadwalForDay(DateTime date) {
    String hari = _getHariFromDate(date);
    return jadwalMingguan[hari] ?? [];
  }

  String _getHariFromDate(DateTime date) {
    int weekday = date.weekday;
    switch (weekday) {
      case 1:
        return "Senin";
      case 2:
        return "Selasa";
      case 3:
        return "Rabu";
      case 4:
        return "Kamis";
      case 5:
        return "Jumat";
      case 6:
        return "Sabtu";
      case 7:
        return "Minggu";
      default:
        return "Senin";
    }
  }
}
