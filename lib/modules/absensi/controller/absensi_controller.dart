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
}
