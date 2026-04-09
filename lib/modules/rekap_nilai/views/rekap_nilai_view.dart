import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/modules/rekap_nilai/controller/rekap_nilai_controller.dart';

class RekapNilaiView extends GetView<RekapNilaiController> {
  const RekapNilaiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rekap Nilai & Analisis')),
      body: Center(
        child: Text('Rekap Nilai & Analisis', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
