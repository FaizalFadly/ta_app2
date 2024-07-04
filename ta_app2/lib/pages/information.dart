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
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Row(
            children: [
              Text(
                'Information',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(10.0),
            child: Divider(
              height: 10.0,
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
            children: [
              Container(
                margin: EdgeInsets.only(top: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 150,
                      width: 300,
                      decoration: BoxDecoration(
                        border: Border.all(
                            style: BorderStyle.solid, color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
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
                      child: PageView(
                        children: [
                          Image.asset('assets/other/sawi1.png',
                              fit: BoxFit.cover),
                          Image.asset('assets/other/sawi2.png',
                              fit: BoxFit.cover),
                          Image.asset('assets/other/sawi3.png',
                              fit: BoxFit.cover),
                        ],
                      ),
                    ),
                    SizedBox(height: 50),
                    Container(
                      height: 370,
                      padding: EdgeInsets.all(16.0),
                      margin: EdgeInsets.symmetric(
                        horizontal: 25.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
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
                          SizedBox(height: 20),
                          Text(
                            'Alat dan Bahan :',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '* Sensor pH',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                            ),
                          ),
                          Text(
                            '* Sensor TDS',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                            ),
                          ),
                          // Text(
                          //   '* Mikrokontroler',
                          //   style: TextStyle(
                          //     color: Colors.black,
                          //     fontSize: 14.0,
                          //   ),
                          // ),
                          SizedBox(height: 20),
                          Text(
                            'Langkah-langkah :',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '* Kalibrasi sensor',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                            ),
                          ),
                          Text(
                            '* Integrasi sensor dengan mikrokontroler',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                            ),
                          ),
                          Text(
                            '* Implementasi algoritma Decision Tree',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
