import 'package:flutter/material.dart';
import '../../../core/widgets/app_badge.dart';
import '../../../config/app_colors.dart';

class AbsensiStudentItem extends StatelessWidget {
  final String nama;
  final String nis;
  final String status;
  final void Function(String) onSelectStatus;

  const AbsensiStudentItem({
    super.key,
    required this.nama,
    required this.nis,
    required this.status,
    required this.onSelectStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// NAMA & NIS
          Text(
            nama,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            "NIS: $nis",
            style: const TextStyle(color: AppColors.textMedium),
          ),

          const SizedBox(height: 12),

          /// STATUS SELECTOR
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _statusButton("Hadir", AppColors.success),
              _statusButton("Izin", AppColors.warning),
              _statusButton("Sakit", AppColors.info),
              _statusButton("Alpha", AppColors.error),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statusButton(String text, Color color) {
    final bool selected = (status == text);

    return GestureDetector(
      onTap: () => onSelectStatus(text),
      child: AppBadge(
        text: text,
        color: selected ? color : color.withOpacity(0.25),
        textColor: selected ? Colors.white : color,
      ),
    );
  }
}
