import 'dart:math';

import 'package:flutter/material.dart';
import 'package:untitled6/pages/sixth_page.dart';

class FifthPage extends StatefulWidget {
  final String carNumber;

  FifthPage({required this.carNumber});

  @override
  _FifthPageState createState() => _FifthPageState();
}

class _FifthPageState extends State<FifthPage> {
  String slotNumber = "";

  void _generateRandomSlotNumber() {
    // Implement your logic to generate a random slot number (a-z, 0-9)
    // For example, you can use the Random class for this task.
    // Here's a simple example:
    final letters = 'abcdefghijklmnopqrstuvwxyz';
    final numbers = '0123456789';
    final random = Random();
    final letter = letters[random.nextInt(letters.length)];
    final number = numbers[random.nextInt(numbers.length)];
    setState(() {
      slotNumber = '$letter$number';
    });
  }

  @override
  void initState() {
    super.initState();
    _generateRandomSlotNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(' Your Parking Slot Number: $slotNumber',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
            Text('Slot is booked for ${widget.carNumber}',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            Text('TAKE SCREENSHOT OF THIS PAGE',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SixthPage(),
                  ),
                );
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}


