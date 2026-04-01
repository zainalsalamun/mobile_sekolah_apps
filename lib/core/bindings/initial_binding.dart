import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/modules/auth/controller/login_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController(), permanent: true);
    // Get.put(ApiService());
    // Get.put(AuthenticationService());
  }
}
