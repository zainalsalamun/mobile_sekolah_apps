import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/modules/artikel/controllers/artikel_controller.dart';

class ArtikelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArtikelController>(() => ArtikelController());
  }
}
