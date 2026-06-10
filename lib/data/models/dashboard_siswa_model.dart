class DashboardSiswaModel {
  final String nama;
  final String kelas;
  final String nis;
  final String statusAbsensi;
  final int nilaiRataRata;

  DashboardSiswaModel({
    required this.nama,
    required this.kelas,
    required this.nis,
    required this.statusAbsensi,
    required this.nilaiRataRata,
  });

  factory DashboardSiswaModel.fromJson(Map<String, dynamic> json) {
    return DashboardSiswaModel(
      nama: json['nama'] ?? '',
      kelas: json['kelas'] ?? '',
      nis: json['nis']?.toString() ?? '',
      statusAbsensi: json['status_absensi'] ?? '',
      nilaiRataRata: json['nilai_rata_rata'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'kelas': kelas,
      'nis': nis,
      'status_absensi': statusAbsensi,
      'nilai_rata_rata': nilaiRataRata,
    };
  }
}