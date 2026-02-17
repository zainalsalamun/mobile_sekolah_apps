import 'package:mobile_sekolah_apps/modules/profile/views/profile_view.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/core/bindings/absensi_binding.dart';
import 'package:mobile_sekolah_apps/modules/setting/bindings/setting_binding.dart';
import 'package:mobile_sekolah_apps/modules/setting/views/setting_view.dart';
import 'package:mobile_sekolah_apps/modules/setting/views/change_password_view.dart';
import 'package:mobile_sekolah_apps/modules/setting/views/about_view.dart';
import 'package:mobile_sekolah_apps/core/bindings/dashboard_guru_binding.dart';
import 'package:mobile_sekolah_apps/core/bindings/dashboard_siswa_binding.dart';
import 'package:mobile_sekolah_apps/core/bindings/jadwal_binding.dart';
import 'package:mobile_sekolah_apps/core/bindings/login_binding.dart';
import 'package:mobile_sekolah_apps/core/bindings/nilai_binding.dart';
import 'package:mobile_sekolah_apps/core/bindings/pengumuman_binding.dart';
import 'package:mobile_sekolah_apps/core/routes/app_routes.dart';
import 'package:mobile_sekolah_apps/modules/absensi/views/absensi_siswa_view.dart';
import 'package:mobile_sekolah_apps/modules/absensi/views/absensi_view.dart';
import 'package:mobile_sekolah_apps/modules/auth/views/login_view.dart';
import 'package:mobile_sekolah_apps/modules/dashboard_guru/views/dashboard_guru_view.dart';
import 'package:mobile_sekolah_apps/modules/dashboard_siswa/views/dashboard_siswa_view.dart';
import 'package:mobile_sekolah_apps/modules/jadwal/views/jadwal_view.dart';
import 'package:mobile_sekolah_apps/modules/nilai/views/nilai_detail_view.dart';
import 'package:mobile_sekolah_apps/modules/nilai/views/nilai_view.dart';
import 'package:mobile_sekolah_apps/modules/pengumuman/views/pengumuman_detail_view.dart';
import 'package:mobile_sekolah_apps/modules/pengumuman/views/pengumuman_view.dart';

import 'package:mobile_sekolah_apps/modules/splash/views/splash_view.dart';
import 'package:mobile_sekolah_apps/modules/izin_siswa/bindings/izin_siswa_binding.dart';
import 'package:mobile_sekolah_apps/modules/izin_siswa/views/izin_siswa_view.dart';
import 'package:mobile_sekolah_apps/modules/artikel/bindings/artikel_binding.dart';
import 'package:mobile_sekolah_apps/modules/artikel/views/artikel_view.dart';
import 'package:mobile_sekolah_apps/modules/artikel/views/artikel_detail_view.dart';
import 'package:mobile_sekolah_apps/modules/kelas_virtual/bindings/kelas_virtual_binding.dart';
import 'package:mobile_sekolah_apps/modules/kelas_virtual/views/kelas_virtual_view.dart';
import 'package:mobile_sekolah_apps/modules/histori/bindings/histori_binding.dart';
import 'package:mobile_sekolah_apps/modules/histori/views/histori_view.dart';
import 'package:mobile_sekolah_apps/modules/tugasku/bindings/tugasku_binding.dart';
import 'package:mobile_sekolah_apps/modules/tugasku/views/tugasku_view.dart';
import 'package:mobile_sekolah_apps/modules/tugasku/views/tugasku_detail_view.dart';
import 'package:mobile_sekolah_apps/modules/point/bindings/point_binding.dart';
import 'package:mobile_sekolah_apps/modules/point/views/point_view.dart';
import 'package:mobile_sekolah_apps/modules/ebook/bindings/ebook_binding.dart';
import 'package:mobile_sekolah_apps/modules/ebook/views/ebook_view.dart';
import 'package:mobile_sekolah_apps/modules/ebook/views/ebook_detail_view.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.splash, page: () => const SplashView()),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.dashboardSiswa,
      page: () => const DashboardSiswaView(),
      binding: DashboardSiswaBinding(),
    ),
    GetPage(
      name: AppRoutes.dashboardGuru,
      page: () => const DashboardGuruView(),
      binding: DashboardGuruBinding(),
    ),
    GetPage(
      name: AppRoutes.absensi,
      page: () => const AbsensiView(),
      binding: AbsensiBinding(),
    ),
    GetPage(
      name: AppRoutes.absensiSiswa,
      page: () => const AbsensiSiswaView(),
      binding: AbsensiBinding(),
    ),

    GetPage(
      name: AppRoutes.nilai,
      page: () => const NilaiView(),
      binding: NilaiBinding(),
    ),

    GetPage(
      name: AppRoutes.detailNilai,
      page: () => const NilaiDetailView(),
      binding: NilaiBinding(),
    ),
    GetPage(
      name: AppRoutes.jadwal,
      page: () => const JadwalView(),
      binding: JadwalBinding(),
    ),
    GetPage(
      name: AppRoutes.pengumuman,
      page: () => const PengumumanView(),
      binding: PengumumanBinding(),
    ),
    GetPage(
      name: AppRoutes.pengumumanDetail,
      page: () => const PengumumanDetailView(),
      binding: PengumumanBinding(),
    ),
    GetPage(
      name: AppRoutes.setting,
      page: () => const SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(name: AppRoutes.profile, page: () => const ProfileView()),
    GetPage(name: '/change-password', page: () => const ChangePasswordView()),
    GetPage(name: '/about', page: () => const AboutView()),
    GetPage(
      name: AppRoutes.izin,
      page: () => const IzinSiswaView(),
      binding: IzinSiswaBinding(),
    ),
    GetPage(
      name: AppRoutes.artikel,
      page: () => const ArtikelView(),
      binding: ArtikelBinding(),
    ),
    GetPage(
      name: AppRoutes.artikelDetail,
      page: () => const ArtikelDetailView(),
    ),
    GetPage(
      name: AppRoutes.kelasVirtual,
      page: () => const KelasVirtualView(),
      binding: KelasVirtualBinding(),
    ),
    GetPage(
      name: AppRoutes.histori,
      page: () => const HistoriView(),
      binding: HistoriBinding(),
    ),
    GetPage(
      name: AppRoutes.tugasku,
      page: () => const TugaskuView(),
      binding: TugaskuBinding(),
    ),
    GetPage(
      name: AppRoutes.tugaskuDetail,
      page: () => const TugaskuDetailView(),
    ),
    GetPage(
      name: AppRoutes.point,
      page: () => const PointView(),
      binding: PointBinding(),
    ),
    GetPage(
      name: AppRoutes.ebook,
      page: () => const EBookView(),
      binding: EBookBinding(),
    ),
    GetPage(name: AppRoutes.ebookDetail, page: () => const EBookDetailView()),
  ];
}
