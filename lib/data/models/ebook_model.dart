class EbookModel {
  final int id;
  final String title;
  final String author;
  final String coverUrl;
  final String category;
  final String description;
  final int pageCount;
  final double rating;

  EbookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.category,
    required this.description,
    required this.pageCount,
    required this.rating,
  });

  factory EbookModel.fromJson(Map<String, dynamic> json) {
    return EbookModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      coverUrl: json['cover_url'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      pageCount: json['page_count'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'cover_url': coverUrl,
      'category': category,
      'description': description,
      'page_count': pageCount,
      'rating': rating,
    };
  }
}