import 'package:mobile_sekolah_apps/data/models/tugas_model.dart';
import 'package:mobile_sekolah_apps/data/providers/api_provider.dart';

class TugasRepository {
  final ApiProvider _apiProvider = ApiProvider.instance;

  Future<List<TugasModel>> getTugas() async {
    try {
      final response = await _apiProvider.get('/tugas');
      final List<dynamic> data = response['data'];
      return data.map((json) => TugasModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load tugas: $e');
    }
  }

  Future<List<TugasModel>> getTugasku() async {
    try {
      final response = await _apiProvider.get('/tugasku');
      final List<dynamic> data = response['data'];
      return data.map((json) => TugasModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load tugasku: $e');
    }
  }

  Future<TugasModel> getTugasDetail(int id) async {
    try {
      final response = await _apiProvider.get('/tugas/$id');
      return TugasModel.fromJson(response['data']);
    } catch (e) {
      throw Exception('Failed to load tugas detail: $e');
    }
  }

  Future<void> submitTugas(int id, Map<String, dynamic> data) async {
    try {
      await _apiProvider.post('/tugas/$id/submit', data: data);
    } catch (e) {
      throw Exception('Failed to submit tugas: $e');
    }
  }

  Future<TugasModel> createTugas(Map<String, dynamic> data) async {
    try {
      final response = await _apiProvider.post('/tugas', data: data);
      return TugasModel.fromJson(response['data']);
    } catch (e) {
      throw Exception('Failed to create tugas: $e');
    }
  }

  Future<TugasModel> updateTugas(int id, Map<String, dynamic> data) async {
    try {
      final response = await _apiProvider.put('/tugas/$id', data: data);
      return TugasModel.fromJson(response['data']);
    } catch (e) {
      throw Exception('Failed to update tugas: $e');
    }
  }

  Future<void> deleteTugas(int id) async {
    try {
      await _apiProvider.delete('/tugas/$id');
    } catch (e) {
      throw Exception('Failed to delete tugas: $e');
    }
  }
}