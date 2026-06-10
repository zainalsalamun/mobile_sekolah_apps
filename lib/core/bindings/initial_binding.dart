import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/modules/auth/controller/login_controller.dart';
import 'package:mobile_sekolah_apps/data/providers/api_provider.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiProvider.instance, permanent: true);
    Get.put(LoginController(), permanent: true);
  }
}
