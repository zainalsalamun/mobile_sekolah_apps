class UserModel {
  final String id;
  final String username;
  final String role;
  final String name;
  final String? token;

  // Siswa fields
  final String? nis;
  final String? nisn;
  final String? kelas;
  final String? jurusan;
  final int? noAbsen;
  final String? jenisKelamin;
  final String? tempatLahir;
  final String? tanggalLahir;
  final String? alamat;
  final String? agama;
  final String? noHp;
  final String? email;
  final String? namaAyah;
  final String? namaIbu;
  final String? pekerjaanAyah;
  final String? pekerjaanIbu;
  final String? tanggalMasuk;
  final String? statusSiswa;
  final String? fotoUrl;

  // Guru fields
  final String? nip;
  final String? jabatan;
  final List<String>? mataPelajaran;
  final List<String>? kelasAmpu;
  final String? pendidikanTerakhir;
  final String? statusKepegawaian;
  final String? golongan;

  UserModel({
    required this.id,
    required this.username,
    required this.role,
    required this.name,
    this.token,
    this.nis,
    this.nisn,
    this.kelas,
    this.jurusan,
    this.noAbsen,
    this.jenisKelamin,
    this.tempatLahir,
    this.tanggalLahir,
    this.alamat,
    this.agama,
    this.noHp,
    this.email,
    this.namaAyah,
    this.namaIbu,
    this.pekerjaanAyah,
    this.pekerjaanIbu,
    this.tanggalMasuk,
    this.statusSiswa,
    this.fotoUrl,
    this.nip,
    this.jabatan,
    this.mataPelajaran,
    this.kelasAmpu,
    this.pendidikanTerakhir,
    this.statusKepegawaian,
    this.golongan,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      username: json['username'] ?? '',
      role: json['role'] ?? '',
      name: json['name'] ?? '',
      token: json['token'],
      nis: json['nis'],
      nisn: json['nisn'],
      kelas: json['kelas'],
      jurusan: json['jurusan'],
      noAbsen: json['no_absen'],
      jenisKelamin: json['jenis_kelamin'],
      tempatLahir: json['tempat_lahir'],
      tanggalLahir: json['tanggal_lahir'],
      alamat: json['alamat'],
      agama: json['agama'],
      noHp: json['no_hp'],
      email: json['email'],
      namaAyah: json['nama_ayah'],
      namaIbu: json['nama_ibu'],
      pekerjaanAyah: json['pekerjaan_ayah'],
      pekerjaanIbu: json['pekerjaan_ibu'],
      tanggalMasuk: json['tanggal_masuk'],
      statusSiswa: json['status_siswa'],
      fotoUrl: json['foto_url'],
      nip: json['nip'],
      jabatan: json['jabatan'],
      mataPelajaran: json['mata_pelajaran'] != null
          ? List<String>.from(json['mata_pelajaran'])
          : null,
      kelasAmpu: json['kelas_ampu'] != null
          ? List<String>.from(json['kelas_ampu'])
          : null,
      pendidikanTerakhir: json['pendidikan_terakhir'],
      statusKepegawaian: json['status_kepegawaian'],
      golongan: json['golongan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'role': role,
      'name': name,
      'token': token,
      'nis': nis,
      'nisn': nisn,
      'kelas': kelas,
      'jurusan': jurusan,
      'no_absen': noAbsen,
      'jenis_kelamin': jenisKelamin,
      'tempat_lahir': tempatLahir,
      'tanggal_lahir': tanggalLahir,
      'alamat': alamat,
      'agama': agama,
      'no_hp': noHp,
      'email': email,
      'nama_ayah': namaAyah,
      'nama_ibu': namaIbu,
      'pekerjaan_ayah': pekerjaanAyah,
      'pekerjaan_ibu': pekerjaanIbu,
      'tanggal_masuk': tanggalMasuk,
      'status_siswa': statusSiswa,
      'foto_url': fotoUrl,
      'nip': nip,
      'jabatan': jabatan,
      'mata_pelajaran': mataPelajaran,
      'kelas_ampu': kelasAmpu,
      'pendidikan_terakhir': pendidikanTerakhir,
      'status_kepegawaian': statusKepegawaian,
      'golongan': golongan,
    };
  }

  bool get isSiswa => role == 'siswa';
  bool get isGuru => role == 'guru';
}