import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/modules/kelas_virtual/controllers/kelas_virtual_controller.dart';

class KelasVirtualBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KelasVirtualController>(() => KelasVirtualController());
  }
}
