import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class EBookController extends GetxController {
  var ebooks = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadParams();
  }

  void loadParams() async {
    isLoading.value = true;
    try {
      await loadEBooks();
    } catch (e) {
      print("Error loading ebooks: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadEBooks() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/data/ebooks.json',
      );
      final List<dynamic> data = jsonDecode(response);
      ebooks.value = data.cast<Map<String, dynamic>>();
    } catch (e) {
      print("Error loading ebooks: $e");
    }
  }

  // Search Logic
  var searchQuery = ''.obs;
  var isSearching = false.obs;

  List<Map<String, dynamic>> get filteredEbooks {
    if (searchQuery.value.isEmpty) {
      return ebooks;
    }
    return ebooks.where((book) {
      final title = (book['title'] ?? '').toString().toLowerCase();
      final author = (book['author'] ?? '').toString().toLowerCase();
      final category = (book['category'] ?? '').toString().toLowerCase();
      final query = searchQuery.value.toLowerCase();
      return title.contains(query) ||
          author.contains(query) ||
          category.contains(query);
    }).toList();
  }

  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
      searchQuery.value = '';
    }
  }

  void updateSearch(String query) {
    searchQuery.value = query;
  }
}
