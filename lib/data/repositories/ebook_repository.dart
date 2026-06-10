import 'package:mobile_sekolah_apps/data/models/ebook_model.dart';
import 'package:mobile_sekolah_apps/data/providers/api_provider.dart';

class EbookRepository {
  final ApiProvider _apiProvider = ApiProvider.instance;

  Future<List<EbookModel>> getEbooks() async {
    try {
      final response = await _apiProvider.get('/ebooks');
      final List<dynamic> data = response['data'];
      return data.map((json) => EbookModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load ebooks: $e');
    }
  }

  Future<EbookModel> getEbookDetail(int id) async {
    try {
      final response = await _apiProvider.get('/ebooks/$id');
      return EbookModel.fromJson(response['data']);
    } catch (e) {
      throw Exception('Failed to load ebook detail: $e');
    }
  }
}