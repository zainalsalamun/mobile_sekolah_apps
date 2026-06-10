class PoinModel {
  final int id;
  final String activity;
  final String date;
  final int points;
  final String type;

  PoinModel({
    required this.id,
    required this.activity,
    required this.date,
    required this.points,
    required this.type,
  });

  factory PoinModel.fromJson(Map<String, dynamic> json) {
    return PoinModel(
      id: json['id'] ?? 0,
      activity: json['activity'] ?? '',
      date: json['date'] ?? '',
      points: json['points'] ?? 0,
      type: json['type'] ?? 'plus',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'activity': activity,
      'date': date,
      'points': points,
      'type': type,
    };
  }
}