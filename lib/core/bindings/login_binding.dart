import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/modules/auth/controller/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
