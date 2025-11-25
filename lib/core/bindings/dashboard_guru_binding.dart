import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/modules/dashboard_guru/controller/dashboard_guru_controller.dart';

class DashboardGuruBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardGuruController());
  }
}
