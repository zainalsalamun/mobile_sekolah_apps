import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/modules/catatan_siswa/controller/catatan_siswa_controller.dart';

class CatatanSiswaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CatatanSiswaController>(() => CatatanSiswaController());
  }
}
