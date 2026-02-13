import 'package:get/get.dart';
import '../controllers/tugasku_controller.dart';

class TugaskuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TugaskuController>(() => TugaskuController());
  }
}
