import 'package:flutter/material.dart';

class NotificationItem {
  final String title;
  final String message;
  final DateTime dateTime;

  NotificationItem({
    required this.title,
    required this.message,
    required this.dateTime,
  });
}

class NotificationModel with ChangeNotifier {
  final List<NotificationItem> _notifications = [];

  List<NotificationItem> get notifications => List.unmodifiable(_notifications);

  void addNotification(String title, String message) {
    _notifications.add(
      NotificationItem(
        title: title,
        message: message,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void removeNotification(int index) {
    _notifications.removeAt(index);
    notifyListeners();
  }
}
