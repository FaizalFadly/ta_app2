import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ta_app2/utils/api_services.dart';
import 'package:ta_app2/pages/detail_notifikasi.dart';
import 'package:ta_app2/models/notification_model.dart';

class NotificationPage extends StatefulWidget {
  List<NotificationItem> notifications;
  final Function(int) removeNotification;

  NotificationPage({
    required this.notifications,
    required this.removeNotification,
  });

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifikasi'),
      ),
      body: ListView.builder(
        itemCount: widget.notifications.length,
        itemBuilder: (context, index) {
          final notification = widget.notifications[index];
          String formattedDate =
              DateFormat('yyyy-MM-dd HH:mm').format(notification.dateTime);
          return ListTile(
            title: Text(notification.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formattedDate,
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
            isThreeLine: true,
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                bool confirmed = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Konfirmasi Hapus'),
                    content: Text('Anda yakin ingin menghapus notifikasi ini?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('Tidak'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text('Ya'),
                      ),
                    ],
                  ),
                );

                if (confirmed) {
                  final removedNotification = widget.notifications[index];
                  widget.removeNotification(index);

                  try {
                    await apiService.deletePrediction(notification.id);
                  } catch (e) {
                    // Handle error and restore the notification in case of failure
                    setState(() {
                      widget.notifications.insert(index, removedNotification);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Gagal menghapus ${notification.title}'),
                      ),
                    );
                    return;
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${notification.title} dihapus'),
                    ),
                  );
                }
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      NotificationDetailPage(notification: notification),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
