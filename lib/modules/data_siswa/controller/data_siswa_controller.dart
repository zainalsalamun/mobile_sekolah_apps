import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/data/models/user_model.dart';
import 'package:mobile_sekolah_apps/data/repositories/user_repository.dart';

class DataSiswaController extends GetxController {
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
}