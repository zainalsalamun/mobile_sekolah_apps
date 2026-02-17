import 'package:flutter/material.dart';
import '../core/routes/app_routes.dart';

class AppMenu {
  static final List<Map<String, dynamic>> items = [
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
      "route": null,
    },
    {
      "title": "Pulsa & Data",
      "icon": Icons.phonelink_ring_rounded,
      "color": const Color(0xFF2D3436),
      "route": null,
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
    {
      "title": "Games",
      "icon": Icons.sports_esports_rounded,
      "color": const Color(0xFFFF7675),
      "route": null,
    },
  ];
}
