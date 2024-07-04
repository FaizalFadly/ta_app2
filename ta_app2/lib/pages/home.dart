import 'package:ta_app2/pages/calculation.dart';
import 'package:flutter/material.dart';
import 'package:ta_app2/pages/information.dart';
import 'package:ta_app2/pages/notification.dart';
import 'dart:async';

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

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<NotificationItem> notifications = [];
    void removeNotification(int index) {}
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final int waterValue = 0;

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Row(
            children: [
              Text(
                'Welcome to',
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
              SizedBox(width: 4),
              Image.asset(
                'assets/other/datang.png',
                width: 40,
                height: 40,
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff80AF81),
                  Color(0xff80AF81),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          ListView(
            children: [
              SizedBox(height: 100),
              // Center(
              //   child: Text(
              //     'METODE DECISION TREE\nBERBASIS MOBILE PADA SISTEM PEMBERIAN\nLARUTAN NUTRISI PADA RESERVOIR\nHIDROPONIK SAWI',
              //     textAlign: TextAlign.center,
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 22,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              SizedBox(height: 40),
              Container(
                width: 250,
                height: 170,
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  border:
                      Border.all(style: BorderStyle.solid, color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 5,
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
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton<String>(
                  value: 'Device 1',
                  icon: Icon(Icons.arrow_drop_down, color: Colors.green),
                  onChanged: (String? newValue) {},
                  underline: Container(),
                  items: <String>[
                    'Device 1',
                    'Device 2',
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
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoCard(
                        Icons.thermostat, 'Suhu', waterValue, Colors.red),
                    _buildInfoCard(
                        Icons.sunny, 'Intensi', waterValue, Colors.orange),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoCard(Icons.water, 'Air', waterValue, Colors.blue),
                    _buildInfoCard(
                        Icons.water_drop, 'Nutrisi', waterValue, Colors.green),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
      IconData icon, String label, int value, Color iconColor) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: 140,
      height: 50,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.3),
        //     spreadRadius: 5,
        //     blurRadius: 7,
        //     offset: Offset(0, 3),
        //     blurStyle: BlurStyle.outer,
        //   ),
        // ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor),
              SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                '$value',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
