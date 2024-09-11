class NotificationItem {
  final int id;
  final String title;
  final String message;
  final DateTime dateTime;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.dateTime,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      dateTime: DateTime.parse(json['dateTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'dateTime': dateTime.toIso8601String(),
    };
  }
}
