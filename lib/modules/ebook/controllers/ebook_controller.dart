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
}
