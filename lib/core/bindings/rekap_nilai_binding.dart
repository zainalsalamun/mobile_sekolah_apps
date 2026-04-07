import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/modules/rekap_nilai/controller/rekap_nilai_controller.dart';

class RekapNilaiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RekapNilaiController>(() => RekapNilaiController());
  }
}
