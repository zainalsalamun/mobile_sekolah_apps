class ArticleModel {
  final int id;
  final String title;
  final String image;
  final String content;
  final String date;
  final String author;

  ArticleModel({
    required this.id,
    required this.title,
    required this.image,
    required this.content,
    required this.date,
    required this.author,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      content: json['content'] ?? '',
      date: json['date'] ?? '',
      author: json['author'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'content': content,
      'date': date,
      'author': author,
    };
  }
}