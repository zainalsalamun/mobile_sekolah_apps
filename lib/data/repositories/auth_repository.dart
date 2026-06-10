import 'package:mobile_sekolah_apps/data/models/user_model.dart';
import 'package:mobile_sekolah_apps/data/providers/api_provider.dart';

class AuthRepository {
  final ApiProvider _apiProvider = ApiProvider.instance;

  Future<UserModel> login(String username, String password) async {
    try {
      final response = await _apiProvider.post('/login', data: {
        'username': username,
        'password': password,
      });

      if (response['success'] == true) {
        final user = UserModel.fromJson(response['data']);
        await _apiProvider.saveToken(user.token ?? '');
        return user;
      } else {
        throw Exception(response['message'] ?? 'Login failed');
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  Future<void> logout() async {
    try {
      await _apiProvider.post('/logout', data: {});
      await _apiProvider.clearToken();
    } catch (e) {
      await _apiProvider.clearToken();
    }
  }
}