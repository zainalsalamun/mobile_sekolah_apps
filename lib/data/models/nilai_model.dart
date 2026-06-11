class NilaiModel {
  final String nama;
  final int kkm;
  final int rata;
  final int semester;
  final List<int> tugas;
  final int uts;
  final int uas;

  NilaiModel({
    required this.nama,
    required this.kkm,
    required this.rata,
    this.semester = 1,
    required this.tugas,
    required this.uts,
    required this.uas,
  });

  factory NilaiModel.fromJson(Map<String, dynamic> json) {
    return NilaiModel(
      nama: json['nama'] ?? '',
      kkm: json['kkm'] ?? 0,
      rata: json['rata'] ?? 0,
      semester: json['semester'] ?? 1,
      tugas: json['tugas'] != null ? List<int>.from(json['tugas']) : [],
      uts: json['uts'] ?? 0,
      uas: json['uas'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'kkm': kkm,
      'rata': rata,
      'semester': semester,
      'tugas': tugas,
      'uts': uts,
      'uas': uas,
    };
  }
}
