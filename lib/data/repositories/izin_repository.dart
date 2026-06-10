import 'package:mobile_sekolah_apps/data/models/izin_model.dart';
import 'package:mobile_sekolah_apps/data/providers/api_provider.dart';

class IzinRepository {
  final ApiProvider _apiProvider = ApiProvider.instance;

  Future<List<IzinModel>> getIzin() async {
    try {
      final response = await _apiProvider.get('/izin');
      final List<dynamic> data = response['data'];
      return data.map((json) => IzinModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load izin: $e');
    }
  }

  Future<void> submitIzin(Map<String, dynamic> data) async {
    try {
      await _apiProvider.post('/izin', data: data);
    } catch (e) {
      throw Exception('Failed to submit izin: $e');
    }
  }
}