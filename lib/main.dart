import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mobile_sekolah_apps/config/app_theme.dart';
import 'package:mobile_sekolah_apps/core/bindings/initial_binding.dart';
import 'package:mobile_sekolah_apps/core/routes/app_pages.dart';
import 'package:mobile_sekolah_apps/core/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);

  runApp(
    GetMaterialApp(
      title: "School App",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialBinding: InitialBinding(),
      initialRoute: AppRoutes.splash, // <-- UBAH
      getPages: AppPages.pages,
    ),
  );
}
