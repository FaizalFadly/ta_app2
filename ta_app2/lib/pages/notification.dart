import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ta_app2/utils/api_services.dart';
import 'package:ta_app2/pages/detail_notifikasi.dart';
import 'package:ta_app2/models/notification_model.dart';

class NotificationPage extends StatelessWidget {
  final List<NotificationItem> notifications;
  final Function(int) removeNotification;
  final ApiService apiService = ApiService();

  NotificationPage({
    required this.notifications,
    required this.removeNotification,
    required Future<void> Function(int index) deleteNotification,
  });

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
          String formattedDate =
              DateFormat('yyyy-MM-dd HH:mm').format(notification.dateTime);
          return Dismissible(
            key: Key(notification.id.toString()),
            onDismissed: (direction) async {
              await apiService.deletePrediction(notification.id);
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
                    formattedDate,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
              isThreeLine: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NotificationDetailPage(notification: notification),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
