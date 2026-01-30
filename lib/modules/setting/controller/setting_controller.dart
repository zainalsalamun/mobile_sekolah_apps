import 'package:get/get.dart';

class SettingController extends GetxController {
  void logout() {
    Get.offAllNamed('/login');
  }

  void navigateTo(String route) {
    if (route == '/profile') {
      Get.toNamed(route);
      return;
    }

    // Placeholder for other menus
    Get.snackbar(
      "Info",
      "Menu ini belum tersedia",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
