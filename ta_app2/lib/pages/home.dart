import 'dart:convert';
import 'package:ta_app2/models/notification_model.dart';
import 'package:ta_app2/pages/calculation.dart';
import 'package:ta_app2/pages/information.dart';
import 'package:flutter/material.dart';
import 'package:ta_app2/pages/notification.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PageController _pageController;
  int _currentPageIndex = 0;
  final int _numPages = 3;
  Timer? _timer;
  late String sensorId;
  double temperature = 0;
  double nutrient = 0;
  bool isSendDataButtonVisible =
      false; // Variabel untuk mengatur visibilitas button

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageIndex);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _startAutoSlide();
    });
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 4), (Timer timer) {
      if (_currentPageIndex < _numPages - 1) {
        _currentPageIndex++;
      } else {
        _currentPageIndex = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPageIndex,
          duration: Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  Future<void> _fetchSensorData() async {
    try {
      final response = await http
          .get(Uri.parse('https://hidroponik.barierrgate.my.id/api.php'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.isNotEmpty) {
          setState(() {
            temperature =
                data[0]['suhu'] != null ? double.parse(data[0]['suhu']) : 0;
            nutrient =
                data[0]['ppm'] != null ? double.parse(data[0]['ppm']) : 0;
            sensorId = data[0]['id']; // Menyimpan ID dari data sensor
            print('Sensor ID: $sensorId'); // Print ID sensor
            isSendDataButtonVisible = temperature > 0 && nutrient > 0;
          });
        } else {
          setState(() {
            temperature = 0;
            nutrient = 0;
            isSendDataButtonVisible = false;
          });
        }
      } else {
        throw Exception('Failed to load sensor data');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _sendData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('temperature', temperature);
    await prefs.setDouble('nutrient', nutrient);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CalculationPage(),
      ),
    );
  }

  String _formatValue(double value) {
    if (value % 1 == 0) {
      return value.toStringAsFixed(0);
    } else {
      return value.toStringAsFixed(1);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final screenWidth = mediaQueryData.size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          elevation: 0,
          title: Row(
            children: [
              Text('Welcome to'),
              SizedBox(width: 4),
              Image.asset(
                'assets/other/datang.png',
                width: 40,
                height: 40,
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Divider(
              height: 1.0,
              color: Colors.grey,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Container(
                  width: 250,
                  height: 130,
                  decoration: BoxDecoration(
                    border: Border.all(style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 15,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                        blurStyle: BlurStyle.outer,
                      ),
                    ],
                  ),
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _numPages,
                    itemBuilder: (BuildContext context, int index) {
                      return Image.asset(
                        'assets/other/sawi${index + 1}.png',
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 95, vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<String>(
                    value: 'Device 1',
                    icon: Icon(Icons.arrow_drop_down),
                    onChanged: (String? newValue) {},
                    underline: Container(),
                    items: <String>[
                      'Device 1',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          children: [
                            SizedBox(width: 10),
                            Text(
                              value,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 30),
                        width: 130,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 15,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                              blurStyle: BlurStyle.outer,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.thermostat),
                                Text(
                                  'Suhu ',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  _formatValue(temperature),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 35),
                        width: 120,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 15,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                              blurStyle: BlurStyle.outer,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.sunny),
                                Text(
                                  'Nutrisi ',
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  _formatValue(nutrient),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 35),
                ElevatedButton(
                  onPressed: _fetchSensorData,
                  child: Text('Ambil Data'),
                ),
                SizedBox(height: 20),
                // Button baru untuk mengirim data
                Visibility(
                  visible: isSendDataButtonVisible,
                  child: ElevatedButton(
                    onPressed: _sendData,
                    child: Text('Kirim Data'),
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
