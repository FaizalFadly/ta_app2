import 'package:flutter/material.dart';
import 'package:ta_app2/utils/navbar.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToMain();
  }

  _navigateToMain() async {
    await Future.delayed(Duration(seconds: 3), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/other/datang.png'),
            SizedBox(height: 20),
            Text(
              'Hiponik',
              style: TextStyle(fontSize: 24.0),
            ),
          ],
        ),
      ),
    );
  }
}
