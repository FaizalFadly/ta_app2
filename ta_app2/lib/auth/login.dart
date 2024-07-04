import 'package:ta_app2/utils/splasscreen.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(SplashScreen());
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Text(
              'Register',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.green[400],
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Username/Email ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      30.0,
                    ),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              obscureText: !_passwordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                fillColor: Colors.white,
                filled: true,
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              width: w * 0.35,
              padding: EdgeInsets.only(top: w * 0.05),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: w * 0.04,
                    color: Colors.black,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color(0xFFEEEDED),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(w * 0.05),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
