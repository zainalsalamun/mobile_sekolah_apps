class NotifikasiModel {
  final int id;
  final String title;
  final String message;
  final String date;
  final bool isRead;
  final String type;

  NotifikasiModel({
    required this.id,
    required this.title,
    required this.message,
    required this.date,
    required this.isRead,
    required this.type,
  });

  factory NotifikasiModel.fromJson(Map<String, dynamic> json) {
    return NotifikasiModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      date: json['date'] ?? '',
      isRead: json['isRead'] ?? false,
      type: json['type'] ?? 'umum',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'date': date,
      'isRead': isRead,
      'type': type,
    };
  }
}