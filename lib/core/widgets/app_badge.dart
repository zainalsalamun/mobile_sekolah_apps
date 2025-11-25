import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

class AppBadge extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;

  const AppBadge({
    super.key,
    required this.text,
    required this.color,
    this.textColor = Colors.white,
  });

  factory AppBadge.success(String text) =>
      AppBadge(text: text, color: AppColors.success);

  factory AppBadge.error(String text) =>
      AppBadge(text: text, color: AppColors.error);

  factory AppBadge.warning(String text) =>
      AppBadge(text: text, color: AppColors.warning);

  factory AppBadge.info(String text) =>
      AppBadge(text: text, color: AppColors.info);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
