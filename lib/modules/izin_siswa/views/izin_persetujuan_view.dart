import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/izin_persetujuan_controller.dart';
import '../../../config/app_colors.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_input.dart';

class IzinPersetujuanView extends StatelessWidget {
  final IzinPersetujuanController controller = Get.put(
    IzinPersetujuanController(),
  );
  final DateFormat dateFormat = DateFormat('dd MMM yyyy', 'id_ID');

  IzinPersetujuanView({super.key});

  Color getStatusColor(String status) {
    switch (status) {
      case 'Menunggu':
        return AppColors.warning;
      case 'Disetujui':
        return AppColors.success;
      case 'Ditolak':
        return AppColors.error;
      default:
        return Colors.grey;
    }
  }

  void showTolakDialog(String idIzin) {
    final alasanC = TextEditingController();
    Get.dialog(
      AlertDialog(
        title: const Text('Tolak Izin'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Alasan penolakan:'),
            const SizedBox(height: 12),
            AppInput(
              controller: alasanC,
              label: 'Alasan Penolakan',
              hint: 'Masukkan alasan...',
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              if (alasanC.text.isNotEmpty) {
                controller.tolakIzin(idIzin, alasanC.text);
                Get.back();
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Tolak', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Persetujuan Izin Siswa'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              tabs: [Tab(text: 'Menunggu Persetujuan'), Tab(text: 'Riwayat')],
              labelColor: AppColors.primary,
              unselectedLabelColor: Colors.grey,
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: LoadingIndicator());
                }

                return TabBarView(
                  children: [
                    // Tab Menunggu Persetujuan
                    RefreshIndicator(
                      onRefresh: () async => controller.loadDataIzin(),
                      child:
                          controller.daftarIzinMenunggu.isEmpty
                              ? const EmptyState(
                                title: 'Tidak Ada Izin',
                                subtitle:
                                    'Tidak ada izin yang menunggu persetujuan',
                              )
                              : ListView.builder(
                                padding: const EdgeInsets.all(16),
                                itemCount: controller.daftarIzinMenunggu.length,
                                itemBuilder: (context, index) {
                                  final izin =
                                      controller.daftarIzinMenunggu[index];
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    child: AppCard(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  izin['nama_siswa'] ?? '-',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: getStatusColor(
                                                    izin['status'],
                                                  ).withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                  izin['status'],
                                                  style: TextStyle(
                                                    color: getStatusColor(
                                                      izin['status'],
                                                    ),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Kelas: ${izin['kelas'] ?? '-'} | NIS: ${izin['nis'] ?? '-'}',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 13,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Tanggal: ${dateFormat.format(DateTime.parse(izin['tanggal']))}',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 13,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Alasan: ${izin['alasan_izin'] ?? '-'}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                  onPressed:
                                                      () => controller
                                                          .setujuiIzin(
                                                            izin['id'],
                                                          ),
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        AppColors.success,
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          vertical: 16,
                                                        ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'Setujui',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: ElevatedButton(
                                                  onPressed:
                                                      () => showTolakDialog(
                                                        izin['id'],
                                                      ),
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        AppColors.error,
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          vertical: 16,
                                                        ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'Tolak',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                    ),

                    // Tab Riwayat
                    RefreshIndicator(
                      onRefresh: () async => controller.loadDataIzin(),
                      child:
                          controller.daftarIzinRiwayat.isEmpty
                              ? const EmptyState(
                                title: 'Riwayat Kosong',
                                subtitle: 'Belum ada riwayat persetujuan izin',
                              )
                              : ListView.builder(
                                padding: const EdgeInsets.all(16),
                                itemCount: controller.daftarIzinRiwayat.length,
                                itemBuilder: (context, index) {
                                  final izin =
                                      controller.daftarIzinRiwayat[index];
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    child: AppCard(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  izin['nama_siswa'] ?? '-',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: getStatusColor(
                                                    izin['status'],
                                                  ).withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                  izin['status'],
                                                  style: TextStyle(
                                                    color: getStatusColor(
                                                      izin['status'],
                                                    ),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            '${izin['kelas']} | ${dateFormat.format(DateTime.parse(izin['tanggal']))}',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 13,
                                            ),
                                          ),
                                          if (izin['alasan_tolak'] != null)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8,
                                              ),
                                              child: Text(
                                                'Alasan Ditolak: ${izin['alasan_tolak']}',
                                                style: TextStyle(
                                                  color: AppColors.error,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
