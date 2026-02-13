import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/histori_controller.dart';
import '../../../config/app_colors.dart';

class HistoriView extends GetView<HistoriController> {
  const HistoriView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histori'),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          "Halaman Histori",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
