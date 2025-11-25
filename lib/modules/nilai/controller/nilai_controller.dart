import 'package:get/get.dart';

class NilaiController extends GetxController {
  // Dummy data nilai per mapel
  var mapelList =
      [
        {"nama": "Matematika", "rata": 84, "kkm": 75},
        {"nama": "Fisika", "rata": 78, "kkm": 75},
        {"nama": "Kimia", "rata": 65, "kkm": 75},
      ].obs;

  // Dummy detail nilai
  final detailNilai =
      {
        "mapel": "Matematika",
        "kkm": 75,
        "data": [
          {"tipe": "Tugas", "nilai": 85},
          {"tipe": "Harian", "nilai": 80},
          {"tipe": "UTS", "nilai": 82},
          {"tipe": "UAS", "nilai": 89},
        ],
      }.obs;
}
