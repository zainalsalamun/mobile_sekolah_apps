import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/modules/catatan_siswa/controller/catatan_siswa_controller.dart';

class CatatanSiswaView extends GetView<CatatanSiswaController> {
  const CatatanSiswaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catatan Konseling Siswa')),
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
                          siswa['nama'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          initialValue: siswa['catatan'],
                          decoration: const InputDecoration(
                            labelText: 'Catatan',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (text) {
                            siswa['catatan'] = text;
                          },
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            controller.saveCatatan(
                              siswa['id'],
                              siswa['catatan'],
                            );
                          },
                          child: const Text('Simpan'),
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
