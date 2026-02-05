import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/config/app_colors.dart';

class ArtikelDetailView extends StatelessWidget {
  const ArtikelDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> article = Get.arguments ?? {};

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                article['image'] ?? "https://picsum.photos/600/300",
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) =>
                        Container(color: Colors.grey),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  article['title'] ?? "Judul Artikel",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: AppColors.textMedium,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      article['date'] ?? "-",
                      style: const TextStyle(color: AppColors.textMedium),
                    ),
                    const SizedBox(width: 16),
                    const Icon(
                      Icons.person,
                      size: 14,
                      color: AppColors.textMedium,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      article['author'] ?? "-",
                      style: const TextStyle(color: AppColors.textMedium),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  article['content'] ?? "",
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textDark,
                    height: 1.6,
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
