import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/data/repositories/izin_repository.dart';

class IzinSiswaController extends GetxController {
  final IzinRepository _izinRepository = IzinRepository();

  final selectedType = "Izin".obs;
  final selectedDate = Rxn<DateTime>();
  final descriptionController = TextEditingController();
  final selectedImage = Rxn<String>();
  final isSubmitting = false.obs;

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
              primary: Color(0xFF1E6FFB),
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
    Get.snackbar(
      "Info",
      "Fitur pilih gambar divirtualisasi (image_picker not installed)",
    );
  }

  Future<void> submitIzin() async {
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

    try {
      isSubmitting.value = true;

      final data = {
        'type': selectedType.value,
        'date': selectedDate.value!.toIso8601String(),
        'description': descriptionController.text,
        'image': selectedImage.value,
      };

      await _izinRepository.submitIzin(data);

      Get.snackbar(
        "Sukses",
        "Pengajuan izin berhasil dikirim",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.back();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal mengirim pengajuan izin: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  @override
  void onClose() {
    descriptionController.dispose();
    super.onClose();
  }
}