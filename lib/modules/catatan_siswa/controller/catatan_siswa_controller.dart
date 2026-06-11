import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/data/models/user_model.dart';
import 'package:mobile_sekolah_apps/data/repositories/user_repository.dart';

class CatatanSiswaController extends GetxController {
  final UserRepository _userRepository = UserRepository();

  final siswaList = <UserModel>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSiswaData();
  }

  Future<void> fetchSiswaData() async {
    isLoading.value = true;
    try {
      final data = await _userRepository.getSiswa();
      siswaList.value = data;
    } catch (e) {
      print('Error loading data: $e');
      siswaList.value = [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveCatatan(int siswaId, String catatan) async {
    try {
      await _userRepository.updateCatatan(siswaId, catatan);

      // Update local state
      final index = siswaList.indexWhere((element) => element.id == siswaId);
      if (index != -1) {
        siswaList.refresh(); // Trigger UI update
      }

      Get.snackbar(
        "Sukses",
        "Catatan berhasil disimpan",
      );
    } catch (e) {
      print('Error saving catatan: $e');
      Get.snackbar(
        "Error",
        "Gagal menyimpan catatan: $e",
      );
    }
  }
}