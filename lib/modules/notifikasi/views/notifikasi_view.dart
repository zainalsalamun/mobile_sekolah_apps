import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/app_colors.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/app_card.dart';
import '../controller/notifikasi_controller.dart';

class NotifikasiView extends StatelessWidget {
  final NotifikasiController controller = Get.put(NotifikasiController());

  NotifikasiView({super.key});

  Color getTypeColor(String type) {
    switch (type) {
      case 'izin':
        return AppColors.warning;
      case 'absensi':
        return AppColors.success;
      case 'tugas':
        return AppColors.primary;
      case 'umum':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  IconData getTypeIcon(String type) {
    switch (type) {
      case 'izin':
        return Icons.assignment_return_rounded;
      case 'absensi':
        return Icons.how_to_reg_rounded;
      case 'tugas':
        return Icons.assignment_outlined;
      case 'umum':
        return Icons.campaign_rounded;
      default:
        return Icons.notifications_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Notifikasi'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          Obx(
            () =>
                controller.unreadCount.value > 0
                    ? TextButton(
                      onPressed: () => controller.markAllAsRead(),
                      child: const Text(
                        'Tandai Semua Dibaca',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                    : const SizedBox.shrink(),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: LoadingIndicator());
        }

        if (controller.daftarNotifikasi.isEmpty) {
          return const EmptyState(
            title: 'Tidak Ada Notifikasi',
            subtitle: 'Semua notifikasi sudah dibaca',
          );
        }

        return RefreshIndicator(
          onRefresh: () => controller.loadNotifikasi(),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.daftarNotifikasi.length,
            itemBuilder: (context, index) {
              final notif = controller.daftarNotifikasi[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: AppCard(
                  padding: const EdgeInsets.all(16),
                  color:
                      notif.isRead
                          ? Colors.white
                          : AppColors.primary.withOpacity(0.05),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icon
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: getTypeColor(notif.type).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                           getTypeIcon(notif.type),
                          color: getTypeColor(notif.type),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    notif.title,
                                    style: TextStyle(
                                      fontWeight:
                                          notif.isRead
                                              ? FontWeight.normal
                                              : FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                if (!notif.isRead)
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                               notif.message,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                               notif.date,
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
