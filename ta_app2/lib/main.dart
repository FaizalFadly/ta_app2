import 'package:flutter/material.dart';
import 'package:ta_app2/auth/login.dart';
import 'package:ta_app2/utils/splasscreen.dart';
import 'package:ta_app2/utils/navbar.dart';
import 'package:ta_app2/pages/home.dart';
import 'package:ta_app2/pages/information.dart';
import 'package:ta_app2/pages/adddevice.dart';
import 'package:ta_app2/pages/calculation.dart';
import 'package:ta_app2/pages/notification.dart';
import 'package:provider/provider.dart';
import 'package:ta_app2/models/notification_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
