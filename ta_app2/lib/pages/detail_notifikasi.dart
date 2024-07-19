import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ta_app2/pages/calculation.dart';

class NotificationDetailPage extends StatelessWidget {
  final NotificationItem notification;

  NotificationDetailPage({required this.notification});

  @override
  Widget build(BuildContext context) {
    String formattedDateTime =
        DateFormat('yyyy-MM-dd HH:mm:').format(notification.dateTime);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Notifikasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${notification.title}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Pesan: ${notification.message}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Tanggal: $formattedDateTime',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
