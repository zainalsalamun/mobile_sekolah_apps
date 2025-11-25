import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/modules/jadwal/controller/jadwal_controller.dart';

class JadwalBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(JadwalController());
  }
}
