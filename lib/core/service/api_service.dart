import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000/api'; // Android emulator
  // Use 'http://localhost:8000/api' for iOS simulator
  // Use 'http://YOUR_IP:8000/api' for real device

  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  late Dio _dio;

  ApiService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Interceptor untuk logging dan token
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add auth token if available
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('auth_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          print('[API REQUEST] ${options.method} ${options.uri}');
          handler.next(options);
        },
        onResponse: (response, handler) {
          print('[API RESPONSE] ${response.statusCode} ${response.requestOptions.uri}');
          handler.next(response);
        },
        onError: (error, handler) {
          print('[API ERROR] ${error.response?.statusCode} ${error.message}');
          handler.next(error);
        },
      ),
    );
  }

  Dio get dio => _dio;

  // Auth
  Future<Response> login(String username, String password) {
    return _dio.post('/login', data: {
      'username': username,
      'password': password,
    });
  }

  Future<Response> logout() {
    return _dio.post('/logout');
  }

  // Dashboard Siswa
  Future<Response> getDashboardSiswa(String siswaId) {
    return _dio.get('/siswa/$siswaId/dashboard');
  }

  // Jadwal
  Future<Response> getJadwalSiswa(String siswaId) {
    return _dio.get('/siswa/$siswaId/jadwal');
  }

  // Nilai
  Future<Response> getNilaiSiswa(String siswaId) {
    return _dio.get('/siswa/$siswaId/nilai');
  }

  // Absensi
  Future<Response> getAbsensiSiswa(String siswaId) {
    return _dio.get('/siswa/$siswaId/absensi');
  }

  Future<Response> getAbsensiRekap(String siswaId) {
    return _dio.get('/siswa/$siswaId/absensi/rekap');
  }

  // Pengumuman
  Future<Response> getPengumuman() {
    return _dio.get('/pengumuman');
  }

  Future<Response> getPengumumanDetail(int id) {
    return _dio.get('/pengumuman/$id');
  }

  // Articles
  Future<Response> getArticles() {
    return _dio.get('/articles');
  }

  Future<Response> getArticleDetail(int id) {
    return _dio.get('/articles/$id');
  }

  // Notifikasi
  Future<Response> getNotifikasi(String userId) {
    return _dio.get('/users/$userId/notifikasi');
  }

  // Points
  Future<Response> getPoints(String siswaId) {
    return _dio.get('/siswa/$siswaId/poin');
  }

  // Tugas
  Future<Response> getTugasSiswa(String siswaId) {
    return _dio.get('/siswa/$siswaId/tugas');
  }

  Future<Response> getTugasGuru(String guruId) {
    return _dio.get('/guru/$guruId/tugas');
  }

  // Ebook
  Future<Response> getEbooks() {
    return _dio.get('/ebooks');
  }

  Future<Response> getEbookDetail(int id) {
    return _dio.get('/ebooks/$id');
  }

  // Izin
  Future<Response> getIzinSiswa(String siswaId) {
    return _dio.get('/siswa/$siswaId/izin');
  }

  Future<Response> submitIzin(String siswaId, Map<String, dynamic> data) {
    return _dio.post('/siswa/$siswaId/izin', data: data);
  }

  // Dashboard Guru
  Future<Response> getDashboardGuru(String guruId) {
    return _dio.get('/guru/$guruId/dashboard');
  }

  // Data Siswa (for guru)
  Future<Response> getDataSiswa(String guruId) {
    return _dio.get('/guru/$guruId/siswa');
  }

  // Rekap Nilai (for guru)
  Future<Response> getRekapNilai(String guruId) {
    return _dio.get('/guru/$guruId/rekap-nilai');
  }

  // Catatan Siswa
  Future<Response> getCatatanSiswa(String guruId) {
    return _dio.get('/guru/$guruId/catatan-siswa');
  }

  // Profil
  Future<Response> getProfilSiswa(String siswaId) {
    return _dio.get('/siswa/$siswaId/profil');
  }

  Future<Response> updateProfilSiswa(String siswaId, Map<String, dynamic> data) {
    return _dio.put('/siswa/$siswaId/profil', data: data);
  }

  // Password
  Future<Response> changePassword(Map<String, dynamic> data) {
    return _dio.post('/change-password', data: data);
  }
}