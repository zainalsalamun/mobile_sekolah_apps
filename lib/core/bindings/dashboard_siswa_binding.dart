import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/modules/dashboard_siswa/controller/dashboard_siswa_controller.dart';

class DashboardSiswaBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardSiswaController());
  }
}
