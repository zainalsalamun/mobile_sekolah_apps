import 'package:get/get.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;

  Future<void> login(String email, String pass) async {
    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 1));

    // sementara masuk dashboard siswa
    // Get.offAllNamed('/dashboard-siswa');
    Get.offAllNamed('/dashboard-guru');

    isLoading.value = false;
  }
}
