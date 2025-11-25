import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../core/widgets/app_card.dart';

class JadwalItem extends StatelessWidget {
  final String jam;
  final String mapel;
  final String guru;
  final String kelas;

  const JadwalItem({
    super.key,
    required this.jam,
    required this.mapel,
    required this.guru,
    required this.kelas,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(jam, style: const TextStyle(color: AppColors.textMedium)),
          const SizedBox(height: 6),
          Text(
            mapel,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(guru, style: const TextStyle(color: AppColors.textMedium)),
          Text(kelas, style: const TextStyle(color: AppColors.textMedium)),
        ],
      ),
    );
  }
}
