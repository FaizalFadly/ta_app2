import 'package:flutter/material.dart';

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
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Row(
            children: [
              Text(
                'Hidroponik',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(width: 4),
              Image.asset(
                'assets/other/datang.png',
                width: 40,
                height: 40,
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(20.0),
            child: Divider(
              height: 20.0,
              color: Colors.white,
            ),
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
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 100),
                child: Center(
                  child: Image.asset(
                    'assets/other/sensor.png',
                    width: 500,
                    height: 200,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                height: 150,
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                      blurStyle: BlurStyle.outer,
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Kamu mempunyai perangkat?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Tambahkan perangkatmu lalu mulai Sensor Kontrol.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
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
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      padding: EdgeInsets.all(16.0),
                      child: GestureDetector(
                        onTap: () {
                          // Logika untuk menambahkan perangkat
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.add,
                              color: Colors.green,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Add Device',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
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
        ],
      ),
    );
  }
}
