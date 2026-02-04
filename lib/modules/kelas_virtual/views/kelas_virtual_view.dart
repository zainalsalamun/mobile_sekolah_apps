import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/config/app_colors.dart';
import 'package:mobile_sekolah_apps/modules/kelas_virtual/controllers/kelas_virtual_controller.dart';

class KelasVirtualView extends GetView<KelasVirtualController> {
  const KelasVirtualView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Kelas Virtual",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.calendar_today_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              // Calendar action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Illustration
            Center(
              child: Image.network(
                "https://cdn-icons-png.flaticon.com/512/3048/3048122.png", // Computer/conference icon
                height: 150,
                errorBuilder:
                    (context, error, stackTrace) => const Icon(
                      Icons.computer,
                      size: 100,
                      color: Colors.blueGrey,
                    ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Buat Kelas Virtual dengan siswa atau guru",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D3436),
              ),
            ),
            const SizedBox(height: 32),

            // Form Fields
            _buildLabel("Nama Kelas Virtual"),
            const SizedBox(height: 8),
            TextField(
              onChanged: (val) => controller.className.value = val,
              decoration: InputDecoration(
                hintText: "Contoh: Kelas Bahasa Indonesia X - A",
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                filled: true,
                fillColor: const Color(0xFFF5F6FA),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
            const SizedBox(height: 20),

            _buildLabel("Host"),
            const SizedBox(height: 8),
            TextField(
              readOnly: true,
              controller: TextEditingController(
                text: controller.hostName.value,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(
                  0xFFF5F6FA,
                ), // Slightly darker to indicate read-only? Or same.
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // Switches
            Obx(
              () => _buildSwitchOption(
                label: "Gunakan Privasi Keamanan",
                description:
                    "Memungkinkan kelas virtual hanya bisa diakses dengan kode akses",
                value: controller.isPrivate.value,
                onChanged: (val) => controller.isPrivate.value = val,
              ),
            ),

            const SizedBox(height: 16),
            Divider(color: Colors.grey.shade200),
            const SizedBox(height: 16),

            Obx(
              () => _buildSwitchOption(
                label: "Jadwalkan Kelas Virtual",
                description:
                    "Buat jadwal kelas dan simpan informasi kelas virtual",
                value: controller.isScheduled.value,
                onChanged: (val) => controller.isScheduled.value = val,
              ),
            ),

            const SizedBox(height: 40),

            // Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (controller.className.value.isNotEmpty) {
                    controller.createClass();
                  } else {
                    Get.snackbar(
                      "Error",
                      "Nama Kelas wajib diisi",
                      backgroundColor: Colors.red.withOpacity(0.1),
                      colorText: Colors.red,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                    0xFF1DD1A1,
                  ), // Teal/Green color from image
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "BUAT KELAS",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color(0xFF636E72), // Greyish text
        ),
      ),
    );
  }

  Widget _buildSwitchOption({
    required String label,
    required String description,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3436),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF636E72),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFF1DD1A1),
          activeTrackColor: const Color(0xFF1DD1A1).withOpacity(0.3),
        ),
      ],
    );
  }
}
