class JadwalModel {
  final String hari;
  final String mapel;
  final String jam;
  final String icon;
  final String guru;
  final String kelas;
  final String? tugas;

  JadwalModel({
    required this.hari,
    required this.mapel,
    required this.jam,
    required this.icon,
    required this.guru,
    required this.kelas,
    this.tugas,
  });

  factory JadwalModel.fromJson(Map<String, dynamic> json) {
    return JadwalModel(
      hari: json['hari'] ?? '',
      mapel: json['mapel'] ?? '',
      jam: json['jam'] ?? '',
      icon: json['icon'] ?? '📖',
      guru: json['guru'] ?? '',
      kelas: json['kelas'] ?? '',
      tugas: json['tugas'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hari': hari,
      'mapel': mapel,
      'jam': jam,
      'icon': icon,
      'guru': guru,
      'kelas': kelas,
      'tugas': tugas,
    };
  }
}