import 'package:ta_app2/pages/calculation.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  final List<NotificationItem> notifications;
  final Function(int) removeNotification;

  NotificationPage(
      {required this.notifications, required this.removeNotification});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifikasi'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Dismissible(
            key: Key(notification.title),
            onDismissed: (direction) {
              removeNotification(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${notification.title} dihapus'),
                ),
              );
            },
            background: Container(
              color: Colors.red,
            ),
            child: ListTile(
              title: Text(notification.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notification.message),
                  Text(
                    '${notification.dateTime}',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
