import 'dart:ffi';

import 'package:flutter/material.dart';

class SixthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/img_1.png'),
            Text('for consuming our', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(' "M4N parking system" ',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

