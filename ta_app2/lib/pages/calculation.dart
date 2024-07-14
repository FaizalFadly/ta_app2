import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ta_app2/pages/home.dart';
import 'package:ta_app2/pages/notification.dart';
import 'package:ta_app2/utils/api_services.dart';

String predictClass(double temperature, double nutrient) {
  if (temperature >= 15 && temperature <= 30) {
    if (nutrient >= 840 && nutrient <= 1400) {
      return "baik: Suhu dan tingkat nutrisi optimal untuk pertumbuhan Sawi.";
    } else {
      return "buruk: Tingkat nutrisi tidak berada dalam kisaran optimal 840-1400 PPM.";
    }
  } else {
    return "buruk: Suhu tidak berada dalam kisaran optimal 15-30°C.";
  }
}

class CalculationPage extends StatefulWidget {
  @override
  _CalculationPageState createState() => _CalculationPageState();
}

class _CalculationPageState extends State<CalculationPage> {
  TextEditingController temperatureController = TextEditingController();
  TextEditingController nutrientController = TextEditingController();
  String prediction = "";

  List<NotificationItem> notifications = [];

  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    loadNotifications();
  }

  Future<void> saveNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = json.encode(
      notifications.map<Map<String, dynamic>>((item) => item.toJson()).toList(),
    );
    await prefs.setString('notifications', encodedData);
  }

  Future<void> loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString('notifications');
    if (encodedData != null) {
      final List<dynamic> decodedData = json.decode(encodedData);
      setState(() {
        notifications = decodedData
            .map<NotificationItem>((item) => NotificationItem.fromJson(item))
            .toList();
      });
    }
  }

  void addNotification(double temperature, double nutrient, String prediction) {
    String temperatureStr = temperature
        .toStringAsFixed(temperature.truncateToDouble() == temperature ? 0 : 1);
    String nutrientStr = nutrient
        .toStringAsFixed(nutrient.truncateToDouble() == nutrient ? 0 : 1);

    setState(() {
      notifications.insert(
        0,
        NotificationItem(
          title: 'Prediksi Baru',
          message:
              'Suhu: $temperatureStr°C, Nutrisi: $nutrientStr ppm, Prediksi: $prediction',
          dateTime: DateTime.now(),
        ),
      );
      saveNotifications();
    });
  }

  void showNutrientInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Informasi Nutrisi'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Makronutrisi:'),
                Text('1. Nitrogen (N): '),
                Text('2. Fosfor (P):  '),
                Text('3. Kalium (K):  '),
                Text('4. Kalsium (Ca):  '),
                Text('5. Magnesium (Mg): '),
                Text('6. Sulfur (S):  '),
                SizedBox(height: 10),
                Text('Mikronutrisi:'),
                Text('1. Besi (Fe):  '),
                Text('2. Mangan (Mn):  '),
                Text('3. Boron (B):  '),
                Text('4. Zinc (Zn):  '),
                Text('5. Tembaga (Cu):  '),
                Text('6. Molibdenum (Mo):  '),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Tutup'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(MyHomePage());
          },
        ),
        title: Text('Hydroponics Decision Tree'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationPage(
                    notifications: notifications,
                    removeNotification: (index) {
                      setState(() {
                        notifications.removeAt(index);
                        saveNotifications();
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: temperatureController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Suhu',
                hintText: '°C',
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: nutrientController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Nutrisi'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.info_outline),
                  onPressed: showNutrientInfo,
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                double temperature =
                    double.tryParse(temperatureController.text) ?? 0.0;
                double nutrient =
                    double.tryParse(nutrientController.text) ?? 0.0;
                setState(() {
                  prediction = predictClass(temperature, nutrient);
                  addNotification(temperature, nutrient, prediction);
                });

                // Panggil sendPrediction untuk mengirim data ke API
                try {
                  await apiService.sendPrediction(
                      temperature, nutrient, prediction);
                } catch (e) {
                  print('Error sending prediction: $e');
                }
              },
              child: Text('Prediksi'),
            ),
            SizedBox(height: 20),
            Text(
              'Prediksi: $prediction',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationItem {
  final String title;
  final String message;
  final DateTime dateTime;

  NotificationItem({
    required this.title,
    required this.message,
    required this.dateTime,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'message': message,
        'dateTime': dateTime.toIso8601String(),
      };

  static NotificationItem fromJson(Map<String, dynamic> json) =>
      NotificationItem(
        title: json['title'],
        message: json['message'],
        dateTime: DateTime.parse(json['dateTime']),
      );
}
