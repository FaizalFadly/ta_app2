import 'package:flutter/material.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({super.key});

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
              Text('Information'),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(10.0),
            child: Divider(
              height: 10.0,
              color: Colors.grey,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 120,
                  width: 270,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 15,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                        blurStyle: BlurStyle.outer,
                      )
                    ],
                  ),
                  child: PageView(
                    children: [
                      Image.asset('assets/other/sawi1.png', fit: BoxFit.cover),
                      Image.asset('assets/other/datang.png',
                          fit: BoxFit.contain),
                      Image.asset('assets/other/datang.png',
                          fit: BoxFit.contain),
                    ],
                  ),
                ),
                SizedBox(height: 100),
                Container(
                  height: 330,
                  width: 270,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 15,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                        blurStyle: BlurStyle.outer,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Deskripsi',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ' Tingkat kepekatan nutrisi yang dibutuhkan tanaman sawi adalah 840-1400 PPM, Sawi dapat tumbuh dengan baik pada suhu rata-rata 15-30°C',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
