import 'package:get/get.dart';

class JadwalController extends GetxController {
  // Hari dalam seminggu
  final hariList = ["Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu"];

  // Index tab hari
  var selectedHariIndex = 0.obs;

  // Dummy Jadwal Mingguan
  var jadwalMingguan =
      {
        "Senin": [
          {
            "jam": "07:00 - 08:30",
            "mapel": "Matematika",
            "guru": "Pak Andi",
            "kelas": "10 IPA 1",
          },
          {
            "jam": "08:30 - 10:00",
            "mapel": "Fisika",
            "guru": "Bu Santi",
            "kelas": "10 IPA 1",
          },
        ],
        "Selasa": [
          {
            "jam": "07:00 - 08:30",
            "mapel": "Biologi",
            "guru": "Bu Maya",
            "kelas": "10 IPA 1",
          },
        ],
        "Rabu": [],
        "Kamis": [],
        "Jumat": [],
        "Sabtu": [],
      }.obs;

  // Jadwal hari ini (auto memakai hari Senin sebagai contoh)
  List get jadwalHariIni => jadwalMingguan["Senin"] ?? [];
}
