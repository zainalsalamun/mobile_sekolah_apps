import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/data/models/nilai_model.dart';
import 'package:mobile_sekolah_apps/data/repositories/nilai_repository.dart';

class RekapNilaiController extends GetxController {
  final NilaiRepository _nilaiRepository = NilaiRepository();

  final nilaiList = <NilaiModel>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNilai();
  }

  Future<void> fetchNilai() async {
    isLoading.value = true;
    try {
      final data = await _nilaiRepository.getNilai();
      nilaiList.value = data;
    } catch (e) {
      print('Error loading rekap nilai: $e');
      nilaiList.value = [];
    } finally {
      isLoading.value = false;
    }
  }

  double get averageNilai {
    if (nilaiList.isEmpty) return 0;
    final total = nilaiList.fold(0.0, (sum, item) => sum + (item.nilai ?? 0));
    return total / nilaiList.length;
  }

  int get totalMataPelajaran => nilaiList.length;

  NilaiModel? get nilaiTertinggi {
    if (nilaiList.isEmpty) return null;
    return nilaiList.reduce((a, b) => (a.nilai ?? 0) > (b.nilai ?? 0) ? a : b);
  }

  NilaiModel? get nilaiTerendah {
    if (nilaiList.isEmpty) return null;
    return nilaiList.reduce((a, b) => (a.nilai ?? 0) < (b.nilai ?? 0) ? a : b);
  }
}