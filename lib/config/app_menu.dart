import 'package:flutter/material.dart';
import '../core/routes/app_routes.dart';

class AppMenu {
  // Menu untuk User Siswa
  static final List<Map<String, dynamic>> siswaItems = [
    {
      "title": "Presensi",
      "icon": Icons.access_alarm_rounded,
      "color": const Color(0xFFFF6B6B),
      "route": AppRoutes.absensiSiswa,
    },
    {
      "title": "Jadwal",
      "icon": Icons.import_contacts_rounded,
      "color": const Color(0xFFC0392B),
      "route": AppRoutes.jadwal,
    },
    {
      "title": "Nilai",
      "icon": Icons.assignment_turned_in_rounded,
      "color": const Color(0xFFE84393),
      "route": AppRoutes.nilai,
    },
    {
      "title": "Izin",
      "icon": Icons.mail_outline_rounded,
      "color": const Color(0xFF74B9FF),
      "route": AppRoutes.izin,
    },
    {
      "title": "Artikel",
      "icon": Icons.article_outlined,
      "color": const Color(0xFFE17055),
      "route": AppRoutes.artikel,
    },
    {
      "title": "E-Book",
      "icon": Icons.menu_book_rounded,
      "color": const Color(0xFF0984E3),
      "route": AppRoutes.ebook,
    },
    {
      "title": "Histori",
      "icon": Icons.calendar_today_rounded,
      "color": const Color(0xFF636E72),
      "route": AppRoutes.histori,
    },
    {
      "title": "Pesan",
      "icon": Icons.chat_bubble_outline_rounded,
      "color": const Color(0xFF00CEC9),
      "route": AppRoutes.pesan,
    },
    {
      "title": "Tugasku",
      "icon": Icons.assignment_outlined,
      "color": const Color(0xFFA29BFE),
      "route": AppRoutes.tugasku,
    },
    {
      "title": "Kelas Virtual",
      "icon": Icons.monitor_rounded,
      "color": const Color(0xFFFD79A8),
      "route": AppRoutes.kelasVirtual,
    },
  ];

  // Menu untuk User Guru
  static final List<Map<String, dynamic>> guruItems = [
    {
      "title": "Absensi Siswa",
      "icon": Icons.how_to_reg_rounded,
      "color": const Color(0xFFFF6B6B),
      "route": AppRoutes.absensi,
    },
    {
      "title": "Persetujuan Izin",
      "icon": Icons.assignment_return_rounded,
      "color": const Color(0xFF9B59B6),
      "route": AppRoutes.persetujuanIzin,
    },
    {
      "title": "Notifikasi",
      "icon": Icons.notifications_rounded,
      "color": const Color(0xFFE74C3C),
      "route": AppRoutes.notifikasi,
    },
    {
      "title": "Jadwal Mengajar",
      "icon": Icons.event_note_rounded,
      "color": const Color(0xFFC0392B),
      "route": AppRoutes.jadwal,
    },
    {
      "title": "Input Nilai",
      "icon": Icons.edit_note_rounded,
      "color": const Color(0xFFE84393),
      "route": AppRoutes.nilai,
    },
    {
      "title": "Rekap Absensi",
      "icon": Icons.assessment_rounded,
      "color": const Color(0xFF27AE60),
      "route": AppRoutes.absensiRekap,
    },
    {
      "title": "Rekap Nilai",
      "icon": Icons.analytics_rounded,
      "color": const Color(0xFF00B894),
      "route": null,
    },
    {
      "title": "Daftar Siswa",
      "icon": Icons.people_alt_rounded,
      "color": const Color(0xFF3498DB),
      "route": null,
    },
    {
      "title": "Pengumuman",
      "icon": Icons.campaign_rounded,
      "color": const Color(0xFFE17055),
      "route": AppRoutes.pengumuman,
    },
    {
      "title": "Tugas",
      "icon": Icons.assignment_outlined,
      "color": const Color(0xFFA29BFE),
      "route": AppRoutes.tugasku,
    },
    {
      "title": "Materi Ajar",
      "icon": Icons.library_books_rounded,
      "color": const Color(0xFF0984E3),
      "route": AppRoutes.ebook,
    },
    {
      "title": "Kelas Virtual",
      "icon": Icons.video_call_rounded,
      "color": const Color(0xFFFD79A8),
      "route": AppRoutes.kelasVirtual,
    },
    {
      "title": "Pengaturan",
      "icon": Icons.settings_rounded,
      "color": const Color(0xFF636E72),
      "route": AppRoutes.setting,
    },
  ];

  // Backward compatibility
  static List<Map<String, dynamic>> get items => siswaItems;

  // Get menu berdasarkan role user
  static List<Map<String, dynamic>> getMenuByRole(String role) {
    if (role == 'guru') {
      return guruItems;
    }
    return siswaItems;
  }
}
