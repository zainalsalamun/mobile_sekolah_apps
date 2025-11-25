import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/modules/absensi/controller/absensi_controller.dart';

class AbsensiBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AbsensiController());
  }
}
