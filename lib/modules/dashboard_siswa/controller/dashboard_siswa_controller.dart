import 'package:get/get.dart';

class DashboardSiswaController extends GetxController {
  var nama = "Zainal Salamun".obs;
  var kelas = "10 IPA 1".obs;

  var statusAbsensi = "Hadir".obs;
  var nilaiRata = 84.obs;

  var jadwalHariIni =
      [
        {"mapel": "Matematika", "jam": "07:30", "icon": "📘"},
        {"mapel": "Fisika", "jam": "09:00", "icon": "🔬"},
        {"mapel": "Kimia", "jam": "10:30", "icon": "🧪"},
        {"mapel": "Biologi", "jam": "12:00", "icon": "👨🏻‍🔬"},
        {"mapel": "Bahasa Indonesia", "jam": "13:30", "icon": "📚"},
        {"mapel": "Bahasa Inggris", "jam": "15:00", "icon": "📚"},
      ].obs;

  var pengumuman =
      [
        {"judul": "Ulangan Umum Dimulai", "tanggal": "12 Nov 2025"},
        {"judul": "Libur Akhir Semester", "tanggal": "05 Des 2025"},
      ].obs;
}
