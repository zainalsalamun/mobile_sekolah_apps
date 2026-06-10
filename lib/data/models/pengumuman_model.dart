class PengumumanModel {
  final int id;
  final String judul;
  final String tanggal;
  final String isi;
  final String kategori;

  PengumumanModel({
    required this.id,
    required this.judul,
    required this.tanggal,
    required this.isi,
    required this.kategori,
  });

  factory PengumumanModel.fromJson(Map<String, dynamic> json) {
    return PengumumanModel(
      id: json['id'] ?? 0,
      judul: json['judul'] ?? '',
      tanggal: json['tanggal'] ?? '',
      isi: json['isi'] ?? '',
      kategori: json['kategori'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'judul': judul,
      'tanggal': tanggal,
      'isi': isi,
      'kategori': kategori,
    };
  }
}