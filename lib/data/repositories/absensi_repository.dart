import 'package:mobile_sekolah_apps/data/models/absensi_model.dart';
import 'package:mobile_sekolah_apps/data/providers/api_provider.dart';

class AbsensiRepository {
  final ApiProvider _apiProvider = ApiProvider.instance;

  Future<List<AbsensiModel>> getAbsensi() async {
    try {
      final response = await _apiProvider.get('/absensi');
      final List<dynamic> data = response['data'];
      return data.map((json) => AbsensiModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load absensi: $e');
    }
  }

  Future<Map<String, dynamic>> getAbsensiSummary() async {
    try {
      final response = await _apiProvider.get('/absensi/summary');
      return response['data'];
    } catch (e) {
      throw Exception('Failed to load absensi summary: $e');
    }
  }
}