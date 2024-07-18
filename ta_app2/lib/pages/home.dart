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
          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.notifications),
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => NotificationPage(
          //             notifications: notifications,
          //             removeNotification: removeNotification,
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ],
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
                // Container(
                //   height: 100,
                //   width: 250,
                //   decoration: BoxDecoration(
                //     border: Border.all(style: BorderStyle.solid),
                //     borderRadius: BorderRadius.circular(10),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.black.withOpacity(0.3),
                //         spreadRadius: 15,
                //         blurRadius: 7,
                //         offset: Offset(0, 3),
                //         blurStyle: BlurStyle.outer,
                //       ),
                //     ],
                //   ),
                //   child: PageView(
                //     children: [
                //       Image.asset('assets/other/datang.png',
                //           fit: BoxFit.contain),
                //       Image.asset('assets/other/datang.png',
                //           fit: BoxFit.contain),
                //       Image.asset('assets/other/datang.png',
                //           fit: BoxFit.contain),
                //     ],
                //   ),
                // ),
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
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 30),
                        width: 140,
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
                                IconButton(
                                  alignment: Alignment.topLeft,
                                  icon: Icon(Icons.thermostat),
                                  color: Colors.black,
                                  onPressed: () {
                                    print('Temperature button pressed');
                                  },
                                ),
                                Text(
                                  'Suhu ',
                                ),
                                SizedBox(width: 1.4),
                                Text(
                                  '$waterValue',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        width: 140,
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
                                IconButton(
                                  alignment: Alignment.topLeft,
                                  icon: Icon(Icons.sunny),
                                  color: Colors.black,
                                  onPressed: () {
                                    print('Nutrisi button pressed');
                                  },
                                ),
                                Text('Nutrisi '),
                                Text(
                                  '$waterValue',
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
                SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
