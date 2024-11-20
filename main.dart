import 'package:flutter/material.dart';
import 'package:untitled6/pages/first_page.dart';
import 'package:untitled6/pages/signinsignup_page.dart';
import 'package:untitled6/pages/second_page.dart';
import 'package:untitled6/pages/third_page.dart';
import 'package:untitled6/pages/fourth_page.dart';
import 'package:untitled6/pages/fifth_page.dart';
import 'package:untitled6/pages/sixth_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Navigator(
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (context) => FirstPage());
            case '/signin':
              return MaterialPageRoute(builder: (context) => SignInSignUpPage());
            case '/second':
              return MaterialPageRoute(builder: (context) => SecondPage());

            default:
              return null; // Handle 404 or other routes
          }
        },
      ),
    );
  }
}
