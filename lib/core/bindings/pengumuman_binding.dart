import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/modules/pengumuman/controller/pengumuman_controller.dart';

class PengumumanBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PengumumanController());
  }
}
