import 'package:get/get.dart';

class DashboardGuruController extends GetxController {
  var nama = "Budi Hartono".obs;
  var mapel = "Guru Matematika".obs;

  var jadwalHariIni =
      [
        {
          "mapel": "Matematika",
          "jam": "07:00",
          "kelas": "10 IPA 1",
          "icon": "📘",
        },
        {
          "mapel": "Matematika",
          "jam": "09:00",
          "kelas": "11 IPA 2",
          "icon": "📘",
        },
        {
          "mapel": "Statistika",
          "jam": "12:30",
          "kelas": "12 IPS 1",
          "icon": "📊",
        },
      ].obs;

  var kelasUntukAbsensi =
      {"mapel": "Matematika", "kelas": "10 IPA 1", "jam": "07:00"}.obs;

  var pengumuman =
      [
        {"judul": "Rapat Guru Besok", "tanggal": "11 Nov 2025"},
        {"judul": "Ulangan Semester", "tanggal": "15 Nov 2025"},
      ].obs;
}
