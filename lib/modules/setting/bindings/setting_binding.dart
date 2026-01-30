import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/modules/setting/controller/setting_controller.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingController>(() => SettingController());
  }
}
