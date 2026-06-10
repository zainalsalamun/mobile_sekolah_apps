import 'package:mobile_sekolah_apps/data/models/nilai_model.dart';
import 'package:mobile_sekolah_apps/data/providers/api_provider.dart';

class NilaiRepository {
  final ApiProvider _apiProvider = ApiProvider.instance;

  Future<List<NilaiModel>> getNilai() async {
    try {
      final response = await _apiProvider.get('/nilai');
      final List<dynamic> data = response['data'];
      return data.map((json) => NilaiModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load nilai: $e');
    }
  }
}