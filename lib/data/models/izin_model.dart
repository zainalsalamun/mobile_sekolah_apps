class IzinModel {
  final int id;
  final String tanggal;
  final String tipe;
  final String keterangan;
  final String statusPersetujuan;
  final String? lampiran;

  IzinModel({
    required this.id,
    required this.tanggal,
    required this.tipe,
    required this.keterangan,
    required this.statusPersetujuan,
    this.lampiran,
  });

  factory IzinModel.fromJson(Map<String, dynamic> json) {
    return IzinModel(
      id: json['id'] ?? 0,
      tanggal: json['tanggal'] ?? '',
      tipe: json['tipe'] ?? '',
      keterangan: json['keterangan'] ?? '',
      statusPersetujuan: json['status_persetujuan'] ?? '',
      lampiran: json['lampiran'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tanggal': tanggal,
      'tipe': tipe,
      'keterangan': keterangan,
      'status_persetujuan': statusPersetujuan,
      'lampiran': lampiran,
    };
  }
}