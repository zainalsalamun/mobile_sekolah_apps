import 'package:mobile_sekolah_apps/data/models/dashboard_siswa_model.dart';
import 'package:mobile_sekolah_apps/data/models/jadwal_model.dart';
import 'package:mobile_sekolah_apps/data/models/pengumuman_model.dart';
import 'package:mobile_sekolah_apps/data/models/article_model.dart';
import 'package:mobile_sekolah_apps/data/models/notifikasi_model.dart';
import 'package:mobile_sekolah_apps/data/models/poin_model.dart';
import 'package:mobile_sekolah_apps/data/providers/api_provider.dart';

class DashboardRepository {
  final ApiProvider _apiProvider = ApiProvider.instance;

  Future<DashboardSiswaModel> getDashboardSiswa() async {
    try {
      final response = await _apiProvider.get('/dashboard/siswa');
      return DashboardSiswaModel.fromJson(response['data']);
    } catch (e) {
      throw Exception('Failed to load dashboard siswa: $e');
    }
  }

  Future<List<JadwalModel>> getJadwalHariIni() async {
    try {
      final response = await _apiProvider.get('/jadwal/hari-ini');
      final List<dynamic> data = response['data'];
      return data.map((json) => JadwalModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load jadwal hari ini: $e');
    }
  }

  Future<List<JadwalModel>> getJadwal() async {
    try {
      final response = await _apiProvider.get('/jadwal');
      final List<dynamic> data = response['data'];
      return data.map((json) => JadwalModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load jadwal: $e');
    }
  }

  Future<List<PengumumanModel>> getPengumuman() async {
    try {
      final response = await _apiProvider.get('/pengumuman');
      final List<dynamic> data = response['data'];
      return data.map((json) => PengumumanModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load pengumuman: $e');
    }
  }

  Future<List<ArticleModel>> getArticles() async {
    try {
      final response = await _apiProvider.get('/articles');
      final List<dynamic> data = response['data'];
      return data.map((json) => ArticleModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load articles: $e');
    }
  }

  Future<List<NotifikasiModel>> getNotifikasi() async {
    try {
      final response = await _apiProvider.get('/notifikasi');
      final List<dynamic> data = response['data'];
      return data.map((json) => NotifikasiModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load notifikasi: $e');
    }
  }

  Future<List<PoinModel>> getPoin() async {
    try {
      final response = await _apiProvider.get('/poin');
      final List<dynamic> data = response['data'];
      return data.map((json) => PoinModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load poin: $e');
    }
  }
}