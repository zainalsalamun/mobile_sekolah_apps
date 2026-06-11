import 'package:mobile_sekolah_apps/data/models/user_model.dart';
import 'package:mobile_sekolah_apps/data/providers/api_provider.dart';

class UserRepository {
  final ApiProvider _apiProvider = ApiProvider.instance;

  Future<List<UserModel>> getUsers({String? role}) async {
    try {
      final queryParams = role != null ? '?role=$role' : '';
      final response = await _apiProvider.get('/users$queryParams');
      final List<dynamic> data = response['data'];
      return data.map((json) => UserModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }

  Future<List<UserModel>> getSiswa() async {
    return getUsers(role: 'siswa');
  }

  Future<UserModel> getUserById(int id) async {
    try {
      final response = await _apiProvider.get('/users/$id');
      return UserModel.fromJson(response['data']);
    } catch (e) {
      throw Exception('Failed to load user: $e');
    }
  }

  Future<void> updateCatatan(int userId, String catatan) async {
    try {
      await _apiProvider.put('/users/$userId', data: {'catatan': catatan});
    } catch (e) {
      throw Exception('Failed to update catatan: $e');
    }
  }
}