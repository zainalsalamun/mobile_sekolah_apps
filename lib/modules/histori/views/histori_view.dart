import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/histori_controller.dart';
import '../../../config/app_colors.dart';

class HistoriView extends GetView<HistoriController> {
  const HistoriView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        appBar: AppBar(
          title: const Text(
            'Histori',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: AppColors.primary,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
            onPressed: () => Get.back(),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [Tab(text: "Absensi"), Tab(text: "Izin")],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [_buildAbsensiTab(), _buildIzinTab()],
              ),
            ),
            // Filter Button Container
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Filter action mock
                    Get.snackbar("Filter", "Fitur filter akan segera tersedia");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                      0xFF00CEC9,
                    ), // Teal color from design
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.filter_list_rounded, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "Filter",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAbsensiTab() {
    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          color: Colors.white,
          child: const Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  "Tanggal",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    "Masuk",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    "Pulang",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.historyAbsensi.isEmpty) {
              return const Center(child: Text("Belum ada data absensi"));
            }
            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: controller.historyAbsensi.length,
              separatorBuilder:
                  (context, index) =>
                      const Divider(height: 1, indent: 20, endIndent: 20),
              itemBuilder: (context, index) {
                final item = controller.historyAbsensi[index];
                return _buildAbsensiItem(item);
              },
            );
          }),
        ),
      ],
    );
  }

  Widget _buildAbsensiItem(Map<String, dynamic> item) {
    String status = item['status'] ?? "-";

    // For specific styling based on image
    // If it's Sunday/Holiday, entire row text might be red or just date.
    // The design shows "Minggu, 22 Mar 2020" in Red.
    // Let's try to detect Sunday from date string if possible or just random for design?
    // The dummy data "19 Jan 2026" doesn't have day name.
    // Let's rely on status. If status is "Libur" or "Minggu" (not in data yet).

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['tanggal'],
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color:
                        (status == "Alpha" || status == "Libur")
                            ? Colors.red
                            : AppColors.textDark,
                  ),
                ),
                if (status != "Hadir" && status != "Alpha" && status != "Libur")
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        fontSize: 10,
                        color: _getStatusColor(status),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                item['masuk'] ?? "-",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                item['pulang'] ?? "-",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Sakit":
        return Colors.orange;
      case "Izin":
        return Colors.blue;
      case "Alpha":
        return Colors.red;
      default:
        return AppColors.primary;
    }
  }

  Widget _buildIzinTab() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.historyIzin.isEmpty) {
        return const Center(child: Text("Belum ada data izin"));
      }
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.historyIzin.length,
        itemBuilder: (context, index) {
          final item = controller.historyIzin[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item['tanggal'],
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: (item['tipe'] == "Sakit"
                                ? Colors.orange
                                : Colors.blue)
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        item['tipe'],
                        style: TextStyle(
                          color:
                              item['tipe'] == "Sakit"
                                  ? Colors.orange
                                  : Colors.blue,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  item['keterangan'] ?? "-",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 12),
                const Divider(),
                Row(
                  children: [
                    const Text("Status: ", style: TextStyle(fontSize: 12)),
                    Text(
                      item['status_persetujuan'] ?? "Menunggu",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color:
                            (item['status_persetujuan'] == "Disetujui")
                                ? Colors.green
                                : Colors.grey,
                      ),
                    ),
                    const Spacer(),
                    if (item['lampiran'] != null)
                      const Row(
                        children: [
                          Icon(
                            Icons.attachment_rounded,
                            size: 14,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "Lampiran",
                            style: TextStyle(color: Colors.blue, fontSize: 12),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
