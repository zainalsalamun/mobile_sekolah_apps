class TugasModel {
  final int id;
  final String title;
  final String deadline;
  final String status;
  final String description;
  final String subject;
  final String teacher;
  final String createdAt;

  TugasModel({
    required this.id,
    required this.title,
    required this.deadline,
    required this.status,
    required this.description,
    required this.subject,
    required this.teacher,
    required this.createdAt,
  });

  factory TugasModel.fromJson(Map<String, dynamic> json) {
    return TugasModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      deadline: json['deadline'] ?? '',
      status: json['status'] ?? '',
      description: json['description'] ?? '',
      subject: json['subject'] ?? '',
      teacher: json['teacher'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'deadline': deadline,
      'status': status,
      'description': description,
      'subject': subject,
      'teacher': teacher,
      'created_at': createdAt,
    };
  }
}