import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_sekolah_apps/data/models/ebook_model.dart';
import 'package:mobile_sekolah_apps/data/repositories/ebook_repository.dart';

class EBookController extends GetxController {
  final EbookRepository _ebookRepository = EbookRepository();

  var ebooks = <EbookModel>[].obs;
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
      debugPrint("Error loading ebooks: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadEBooks() async {
    try {
      final data = await _ebookRepository.getEbooks();
      ebooks.value = data;
    } catch (e) {
      debugPrint("Error loading ebooks: $e");
    }
  }

  // Search Logic
  var searchQuery = ''.obs;
  var isSearching = false.obs;

  List<EbookModel> get filteredEbooks {
    if (searchQuery.value.isEmpty) {
      return ebooks;
    }
    return ebooks.where((book) {
      final title = book.title.toLowerCase();
      final author = book.author.toLowerCase();
      final category = book.category.toLowerCase();
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