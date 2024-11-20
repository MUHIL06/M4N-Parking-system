import 'package:flutter/material.dart';
import 'dart:async';
import 'package:untitled6/pages/signinsignup_page.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignInSignUpPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Logo and "M4 parking system" text
            // You can customize this part
            Container(
              width: 360, // Set the desired width
              height: 200, // Set the desired height
              child: Image.asset("images/img.png"),
            ),
            Text('to', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(
              'M4N parking system',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}


