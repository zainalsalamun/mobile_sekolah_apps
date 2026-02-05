import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DashboardSiswaController extends GetxController {
  var nama = "Zainal Salamun".obs;
  var kelas = "10 IPA 1".obs;

  var statusAbsensi = "Hadir".obs;
  var nilaiRata = 84.obs;

  var jadwalHariIni = <Map<String, dynamic>>[].obs;

  var pengumuman = <Map<String, dynamic>>[].obs;
  var articles = <Map<String, dynamic>>[].obs;
  var notifikasi = <Map<String, dynamic>>[].obs;
  var unreadNotifCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadJadwal();
    loadProfile();
    loadPengumuman();
    loadArticles();
    loadNotifikasi();
  }

  void loadJadwal() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/data/jadwal_siswa.json',
      );
      final List<dynamic> data = jsonDecode(response);

      // Get current day name in Indonesian
      // Note: In real app, use intl package
      String hariIni = _getHariIni();

      // Filter jadwal for today
      var jadwalFiltered =
          data.where((element) => element['hari'] == hariIni).toList();

      // Map to Observable List
      jadwalHariIni.value = jadwalFiltered.cast<Map<String, dynamic>>();
    } catch (e) {
      print("Error loading jadwal: $e");
    }
  }

  String _getHariIni() {
    // 1 = Monday, 7 = Sunday
    int weekday = DateTime.now().weekday;
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
        return "Sabtu"; // Assuming no school on Saturday in this dummy
      case 7:
        return "Minggu";
      default:
        return "Senin";
    }
  }

  void loadProfile() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/data/dashboard_siswa.json',
      );
      final data = jsonDecode(response);

      nama.value = data['nama'];
      kelas.value = data['kelas'];
      statusAbsensi.value = data['status_absensi'];
      nilaiRata.value = data['nilai_rata_rata'];
    } catch (e) {
      print("Error loading profile: $e");
    }
  }

  void loadPengumuman() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/data/pengumuman.json',
      );
      final List<dynamic> data = jsonDecode(response);

      // Sort by DATE descending to show newest chronologically
      data.sort((a, b) {
        DateTime? dateA = _parseDate(a['tanggal']);
        DateTime? dateB = _parseDate(b['tanggal']);
        if (dateA == null || dateB == null) return 0;
        return dateB.compareTo(dateA);
      });

      if (data.isNotEmpty) {
        // Get latest item's date string to determine "last month"
        // Format: "10 Mar 2026" -> split to ["10", "Mar", "2026"]
        String latestDate = data[0]['tanggal'];
        List<String> parts = latestDate.split(' ');

        if (parts.length >= 3) {
          String latestMonthYear =
              "${parts[1]} ${parts[2]}"; // e.g., "Mar 2026"

          // Filter only items with same Month & Year
          var filtered =
              data.where((item) {
                String date = item['tanggal'] ?? "";
                return date.contains(latestMonthYear);
              }).toList();

          pengumuman.value = filtered.cast<Map<String, dynamic>>();
        } else {
          pengumuman.value = data.take(3).toList().cast<Map<String, dynamic>>();
        }
      } else {
        pengumuman.value = [];
      }
    } catch (e) {
      print("Error loading pengumuman: $e");
    }
  }

  DateTime? _parseDate(String? dateStr) {
    if (dateStr == null) return null;
    try {
      var parts = dateStr.split(" ");
      if (parts.length < 3) return null;
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
      "Agu",
      "Sep",
      "Okt",
      "Nov",
      "Des",
    ];
    // English fallback
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

    int index = months.indexOf(monthStr);
    if (index == -1) {
      index = monthsEng.indexOf(monthStr);
    }
    return index + 1;
  }

  void loadNotifikasi() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/data/notifikasi.json',
      );
      final List<dynamic> data = jsonDecode(response);

      notifikasi.value = data.cast<Map<String, dynamic>>();
      unreadNotifCount.value =
          notifikasi.where((n) => n['isRead'] == false).length;
    } catch (e) {
      print("Error loading notifikasi: $e");
    }
  }

  void loadArticles() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/data/articles.json',
      );
      final List<dynamic> data = jsonDecode(response);
      articles.value = data.cast<Map<String, dynamic>>();
    } catch (e) {
      print("Error loading articles: $e");
    }
  }

  void logout() {
    Get.offAllNamed('/login');
  }
}
