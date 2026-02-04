import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IzinSiswaController extends GetxController {
  final selectedType = "Izin".obs;
  final selectedDate = Rxn<DateTime>();
  final descriptionController = TextEditingController();
  // Using String path for simulation since we don't have image_picker
  final selectedImage = Rxn<String>();

  final List<String> izinTypes = [
    "Izin",
    "Sakit",
    "Keperluan Sekolah",
    "Lainnya",
  ];

  void selectType(String type) {
    selectedType.value = type;
  }

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF1E6FFB), // AppColors.primary
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      selectedDate.value = picked;
    }
  }

  Future<void> pickImage() async {
    // Simulated image picker since package is not available
    Get.snackbar(
      "Info",
      "Fitur pilih gambar divirtualisasi (image_picker not installed)",
    );
    // Simulating a successful pick
    // selectedImage.value = "/path/to/virtual/image.jpg";
  }

  void submitIzin() {
    if (selectedDate.value == null) {
      Get.snackbar(
        "Error",
        "Mohon pilih tanggal izin",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (descriptionController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Mohon isi keterangan",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Process submission...
    Get.snackbar(
      "Sukses",
      "Pengajuan izin berhasil dikirim",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    // Ideally go back or clear form
    Get.back();
  }

  @override
  void onClose() {
    descriptionController.dispose();
    super.onClose();
  }
}
