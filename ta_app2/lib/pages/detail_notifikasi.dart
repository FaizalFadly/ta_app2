import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ta_app2/models/notification_model.dart';
import 'package:ta_app2/pages/calculation.dart';
import 'package:ta_app2/pages/information.dart';

class NotificationDetailPage extends StatelessWidget {
  final NotificationItem notification;

  NotificationDetailPage({required this.notification});

  @override
  Widget build(BuildContext context) {
    String formattedDateTime =
        DateFormat('yyyy-MM-dd HH:mm').format(notification.dateTime);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Notifikasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionContent(notification.title),
            SizedBox(height: 20),
            _buildSectionTitle('Pesan'),
            _buildSectionContent(notification.message),
            SizedBox(height: 20),
            _buildSectionTitle('Tanggal'),
            _buildSectionContent(formattedDateTime),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildSectionContent(String content) {
    return Text(
      content,
      style: TextStyle(fontSize: 16),
    );
  }
}
