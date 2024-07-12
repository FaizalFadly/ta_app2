import 'package:ta_app2/pages/calculation.dart';
import 'package:ta_app2/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:ta_app2/pages/notification.dart';

class AddDevicePage extends StatelessWidget {
  const AddDevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          elevation: 0,
          title: Row(
            children: [
              Text('Hiponik'),
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
            preferredSize: Size.fromHeight(20.0),
            child: Divider(
              height: 20.0,
              color: Colors.grey,
            ),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 1),
            child: Center(
              child: Image.asset(
                'assets/other/sensor.png',
                width: 170,
                height: 180,
              ),
            ),
          ),
          SizedBox(height: 2),
          Container(
            height: 120,
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Kamu mempunyai perangkat ?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Tambahkan perangkatmu lalu mulai',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Sensor Kontrol.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 200),
          Container(
            margin: EdgeInsets.only(bottom: 20.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  padding: EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        SizedBox(width: 3),
                        Text(
                          'Add Device',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
