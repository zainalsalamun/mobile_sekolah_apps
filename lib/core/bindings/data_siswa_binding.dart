import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/modules/data_siswa/controller/data_siswa_controller.dart';

class DataSiswaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataSiswaController>(() => DataSiswaController());
  }
}
