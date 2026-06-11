import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/data/models/article_model.dart';
import 'package:mobile_sekolah_apps/data/repositories/dashboard_repository.dart';

class ArtikelController extends GetxController {
  final DashboardRepository _dashboardRepository = DashboardRepository();

  var articles = <ArticleModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadArticles();
  }

  Future<void> loadArticles() async {
    try {
      isLoading.value = true;
      final data = await _dashboardRepository.getArticles();
      articles.value = data;
    } catch (e) {
      debugPrint("Error loading articles: $e");
    } finally {
      isLoading.value = false;
    }
  }
}