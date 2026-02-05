import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ArtikelController extends GetxController {
  var articles = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadArticles();
  }

  Future<void> loadArticles() async {
    try {
      isLoading.value = true;
      final String response = await rootBundle.loadString(
        'assets/data/articles.json',
      );
      final List<dynamic> data = json.decode(response);
      articles.value = data.cast<Map<String, dynamic>>();
    } catch (e) {
      print("Error loading articles: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
