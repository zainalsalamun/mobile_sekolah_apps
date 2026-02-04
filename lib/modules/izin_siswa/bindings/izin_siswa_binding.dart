import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/modules/izin_siswa/controllers/izin_siswa_controller.dart';

class IzinSiswaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IzinSiswaController>(() => IzinSiswaController());
  }
}
