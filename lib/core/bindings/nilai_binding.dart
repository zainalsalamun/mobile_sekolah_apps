import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/modules/nilai/controller/nilai_controller.dart';

class NilaiBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NilaiController());
  }
}
