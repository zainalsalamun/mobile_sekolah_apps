import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';

class JadwalItem extends StatelessWidget {
  final String jam;
  final String mapel;
  final String guru;
  final String kelas;
  final String icon;

  final String? tugas;

  const JadwalItem({
    super.key,
    required this.jam,
    required this.mapel,
    required this.guru,
    required this.kelas,
    this.icon = "📘",
    this.tugas,
  });

  @override
  Widget build(BuildContext context) {
    // Generate a consistent pastel color based on mapel length/hash
    final colors = [
      const Color(0xFFE3F2FD), // Blue
      const Color(0xFFF3E5F5), // Purple
      const Color(0xFFE8F5E9), // Green
      const Color(0xFFFFF3E0), // Orange
      const Color(0xFFFFEBEE), // Red
      const Color(0xFFE0F7FA), // Cyan
    ];
    final colorIndex = mapel.length % colors.length;
    final bgColor = colors[colorIndex];
    final accentColor = _getDarkerColor(bgColor);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: IntrinsicHeight(
          child: Row(
            children: [
              // Decorative Strip
              Container(width: 6, color: accentColor),

              // Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Icon Box
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                icon,
                                style: const TextStyle(fontSize: 24),
                              ),
                            ),
                          ),

                          const SizedBox(width: 14),

                          // Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  mapel,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textDark,
                                  ),
                                ),
                                const SizedBox(height: 6),

                                // Teacher & Room Row
                                Row(
                                  children: [
                                    if (guru != "-" && guru.isNotEmpty) ...[
                                      Icon(
                                        Icons.person_rounded,
                                        size: 14,
                                        color: AppColors.textMedium.withOpacity(
                                          0.8,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          guru,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: AppColors.textMedium
                                                .withOpacity(0.8),
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                    ],

                                    if (kelas != "-" && kelas.isNotEmpty) ...[
                                      Icon(
                                        Icons.location_on_rounded,
                                        size: 14,
                                        color: AppColors.textMedium.withOpacity(
                                          0.8,
                                        ),
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        kelas,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.textMedium
                                              .withOpacity(0.8),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Homework Section
                      if (tugas != null && tugas!.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF4E5), // Soft Orange
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFFFFCC80).withOpacity(0.5),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.assignment_outlined,
                                size: 16,
                                color: Color(0xFFEF6C00),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "PR: $tugas",
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFFE65100),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              // Time Badge (Right Side Vertical or Badge)
              // Let's put it top right inside the content area really, but here is fine too.
              // Actually, putting it in the Column above might be crowded.
              // Let's place it top-right absolutely or just in the row.
              Padding(
                padding: const EdgeInsets.only(right: 16, top: 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Text(
                    jam,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getDarkerColor(Color color) {
    if (color == const Color(0xFFE3F2FD)) return const Color(0xFF2196F3);
    if (color == const Color(0xFFF3E5F5)) return const Color(0xFF9C27B0);
    if (color == const Color(0xFFE8F5E9)) return const Color(0xFF4CAF50);
    if (color == const Color(0xFFFFF3E0)) return const Color(0xFFFF9800);
    if (color == const Color(0xFFFFEBEE)) return const Color(0xFFF44336);
    if (color == const Color(0xFFE0F7FA)) return const Color(0xFF00BCD4);
    return AppColors.primary;
  }
}
