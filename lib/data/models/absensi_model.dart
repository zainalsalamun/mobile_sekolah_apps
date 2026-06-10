class AbsensiModel {
  final String tanggal;
  final String status;
  final String masuk;
  final String pulang;
  final String? note;

  AbsensiModel({
    required this.tanggal,
    required this.status,
    required this.masuk,
    required this.pulang,
    this.note,
  });

  factory AbsensiModel.fromJson(Map<String, dynamic> json) {
    return AbsensiModel(
      tanggal: json['tanggal'] ?? '',
      status: json['status'] ?? '',
      masuk: json['masuk'] ?? '-',
      pulang: json['pulang'] ?? '-',
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tanggal': tanggal,
      'status': status,
      'masuk': masuk,
      'pulang': pulang,
      'note': note,
    };
  }
}