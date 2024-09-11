import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ta_app2/models/notification_model.dart';
import 'package:ta_app2/pages/home.dart';
import 'package:ta_app2/pages/notification.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:ta_app2/utils/api_services.dart';

String predictClass(double temperature, double nutrient) {
  // Jika nutrisi tidak dalam kisaran optimal
  if (nutrient < 840 || nutrient > 1400) {
    if (nutrient < 840) {
      if (temperature < 15) {
        return "Buruk: Suhu rendah dan tingkat nutrisi rendah, tidak optimal untuk pertumbuhan Sawi.";
      } else if (temperature >= 15 && temperature <= 30) {
        return "Buruk: Nutrisi rendah, tidak optimal untuk pertumbuhan Sawi.";
      } else {
        return "Buruk: Suhu tinggi dan tingkat nutrisi rendah, tidak optimal untuk pertumbuhan Sawi.";
      }
    } else {
      // nutrient > 1400
      if (temperature < 15) {
        return "Buruk: Suhu rendah dan tingkat nutrisi tinggi, tidak optimal untuk pertumbuhan Sawi.";
      } else if (temperature >= 15 && temperature <= 30) {
        return "Buruk: Nutrisi tinggi, tidak optimal untuk pertumbuhan Sawi.";
      } else {
        return "Buruk: Suhu tinggi dan tingkat nutrisi tinggi, tidak optimal untuk pertumbuhan Sawi.";
      }
    }
  }
  // Jika nutrisi dalam kisaran optimal
  else if (nutrient >= 840 && nutrient <= 1400) {
    if (temperature < 15) {
      return "Buruk: Suhu rendah, tidak optimal untuk pertumbuhan Sawi.";
    } else if (temperature >= 15 && temperature <= 30) {
      if (nutrient < 900) {
        return "Baik: Suhu optimal, namun tingkat nutrisi mendekati batas bawah.";
      } else if (nutrient > 1300) {
        return "Baik: Suhu optimal, namun tingkat nutrisi mendekati batas atas.";
      } else {
        return "Baik: Suhu dan tingkat nutrisi optimal untuk pertumbuhan Sawi.";
      }
    } else {
      return "Buruk: Suhu tinggi, tidak optimal untuk pertumbuhan Sawi.";
    }
  }
  // Jika suhu tidak dalam kisaran optimal
  else {
    return "Buruk: Suhu tidak berada dalam kisaran optimal 15-30°C.";
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
  String sensorId = '';

  List<NotificationItem> notifications = [];
  int unreadNotifications = 0;

  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    loadNotifications();
    loadParameters();
  }

  Future<void> loadParameters() async {
    final prefs = await SharedPreferences.getInstance();
    double? temperature = prefs.getDouble('temperature');
    double? nutrient = prefs.getDouble('nutrient');
    int? id_sensor = prefs.getInt('id');

    if (temperature != null && nutrient != null) {
      temperatureController.text = formatNumber(temperature);
      nutrientController.text = formatNumber(nutrient);
      prediction = predictClass(temperature, nutrient);
      setState(() {});
    }
  }

  Future<void> deleteNotification(int index) async {
    setState(() {
      notifications.removeAt(index);
    });
    await saveNotifications();
  }

  Future<void> saveNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = json.encode(
      notifications.map<Map<String, dynamic>>((item) => item.toJson()).toList(),
    );
    await prefs.setString('notifications', encodedData);
    await prefs.setInt('unreadNotifications', unreadNotifications);
  }

  Future<void> loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString('notifications');
    final int? unreadCount = prefs.getInt('unreadNotifications');
    if (encodedData != null) {
      final List<dynamic> decodedData = json.decode(encodedData);
      setState(() {
        notifications = decodedData
            .map<NotificationItem>((item) => NotificationItem.fromJson(item))
            .toList();
        unreadNotifications = unreadCount ?? 0;
      });
    }
  }

  String formatNumber(double value) {
    return value % 1 == 0 ? value.toInt().toString() : value.toStringAsFixed(1);
  }

  void addNotification(
      int id, double temperature, double nutrient, String prediction) {
    String temperatureStr = formatNumber(temperature);
    String nutrientStr = formatNumber(nutrient);

    setState(() {
      notifications.insert(
        0,
        NotificationItem(
          id: id,
          title: 'Hasil Prediksi',
          message:
              'Suhu: $temperatureStr°C, Nutrisi: $nutrientStr ppm, Prediksi: $prediction',
          dateTime: DateTime.now(),
        ),
      );
      unreadNotifications++;
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

  void showAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Peringatan'),
          content: Text(message),
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

  void showPredictionNotification(String prediction) {
    Flushbar(
      backgroundColor: Colors.white,
      messageText: Text(
        prediction,
        style: TextStyle(color: Colors.black),
      ),
      duration: Duration(seconds: 5),
      flushbarPosition: FlushbarPosition.TOP,
      mainButton: Row(
        children: [
          TextButton(
            onPressed: () async {
              await Navigator.push(
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
              setState(() {
                unreadNotifications = 0;
                saveNotifications();
              });
            },
            child: Text(
              "Lihat",
              style: TextStyle(color: Colors.blue),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Tutup",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hydroponics Decision Tree'),
        actions: [
          Stack(
            children: [
              // IconButton(
              //   icon: Icon(Icons.notifications),
              //   onPressed: () async {
              //     await Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => NotificationPage(
              //           notifications: notifications,
              //           removeNotification: (index) {
              //             setState(() {
              //               notifications.removeAt(index);
              //               saveNotifications();
              //             });
              //           },
              //         ),
              //       ),
              //     );
              //     setState(() {
              //       unreadNotifications = 0;
              //       saveNotifications();
              //     });
              //   },
              // ),
              // if (unreadNotifications > 0)
              //   Positioned(
              //     right: 11,
              //     top: 11,
              //     child: Container(
              //       padding: EdgeInsets.all(2),
              //       decoration: BoxDecoration(
              //         color: Colors.red,
              //         borderRadius: BorderRadius.circular(6),
              //       ),
              //       constraints: BoxConstraints(
              //         minWidth: 14,
              //         minHeight: 14,
              //       ),
              //       child: Text(
              //         '$unreadNotifications',
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 8,
              //         ),
              //         textAlign: TextAlign.center,
              //       ),
              //     ),
              //   ),
            ],
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
                if (temperatureController.text.isEmpty ||
                    nutrientController.text.isEmpty) {
                  showAlert('Harap isi semua kolom.');
                  return;
                }
                double temperature =
                    double.tryParse(temperatureController.text) ?? 0.0;
                double nutrient =
                    double.tryParse(nutrientController.text) ?? 0.0;
                prediction = predictClass(temperature, nutrient);

                print('Sending data with Sensor ID: $sensorId');

                try {
                  int? id = await apiService.sendPrediction(
                    sensorId,
                    temperature,
                    nutrient,
                    prediction,
                  );

                  if (id != null) {
                    setState(() {
                      addNotification(id, temperature, nutrient, prediction);
                    });

                    await apiService.sendNotification(
                      'Hasil Prediksi',
                      'Suhu: ${formatNumber(temperature)}°C, Nutrisi: ${formatNumber(nutrient)} ppm, Prediksi: $prediction',
                      DateTime.now().toIso8601String(),
                    );

                    showPredictionNotification(prediction);
                  } else {
                    showAlert('Gagal mengirim prediksi.');
                  }
                } catch (e) {
                  print('Error sending prediction: $e');
                  showAlert('Terjadi kesalahan saat mengirim prediksi.');
                }
              },
              child: Text('Prediksi'),
            ),
            SizedBox(height: 20),

            Text(
              'Penilaian: $prediction',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
