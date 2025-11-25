import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

class AppInput extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscure;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int maxLines;

  const AppInput({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
    this.keyboardType = TextInputType.text,
    this.obscure = false,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// LABEL
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 6),

        /// TEXTFIELD
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscure,
          maxLines: obscure ? 1 : maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,

            hintText: hint,

            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),

            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.border),
              borderRadius: BorderRadius.circular(12),
            ),

            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(12),
            ),

            hintStyle: const TextStyle(
              color: AppColors.textLight,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
