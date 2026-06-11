import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/modules/data_siswa/controller/data_siswa_controller.dart';

class DataSiswaView extends GetView<DataSiswaController> {
  const DataSiswaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Siswa')),
      body: Obx(() {
        return controller.siswaList.isEmpty
            ? const Center(child: Text("Tidak ada data siswa"))
            : ListView.builder(
              itemCount: controller.siswaList.length,
              itemBuilder: (context, index) {
                final siswa = controller.siswaList[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          siswa.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Kelas: ${siswa.kelas ?? '-'}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'NISN: ${siswa.nisn ?? '-'}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
      }),
    );
  }
}
