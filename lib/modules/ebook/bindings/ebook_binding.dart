import 'package:get/get.dart';
import '../controllers/ebook_controller.dart';

class EBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EBookController>(() => EBookController());
  }
}
