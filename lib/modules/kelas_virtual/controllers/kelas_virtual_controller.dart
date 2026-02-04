import 'package:get/get.dart';

class KelasVirtualController extends GetxController {
  // Observables for form fields
  var className = ''.obs;
  var hostName = 'Josh Robert'.obs; // Pre-filled as per design
  var isPrivate = false.obs;
  var isScheduled = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void createClass() {
    // Implement create class logic here
    Get.snackbar(
      "Sukses",
      "Kelas Virtual '${className.value}' Berhasil Dibuat",
    );
  }
}
