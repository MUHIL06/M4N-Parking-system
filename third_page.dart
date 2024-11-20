import 'package:flutter/material.dart';
import 'package:untitled6/pages/fourth_page.dart';

class ThirdPage extends StatefulWidget {
  final String vehicleType;
  final String carNumber;
  final DateTime? checkInDateTime;
  final DateTime? checkOutDateTime;

  ThirdPage({
    required this.vehicleType,
    required this.carNumber,
    required this.checkInDateTime,
    required this.checkOutDateTime,
  });

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  String paymentType = "regular"; // Default payment type
  double totalAmount = 0.0; // Total payment amount

  void _calculateTotalAmount() {
    double hourlyRate = 0.0;
    int hoursBetween = 0;

    try {
      if (widget.vehicleType == "car") {
        if (paymentType == "regular") {
          hoursBetween = widget.checkOutDateTime!.difference(widget.checkInDateTime!).inHours;
          if (hoursBetween == 24) {
            totalAmount = 500.0;
          } else if (hoursBetween == 1) {
            hourlyRate = 40.0;
            totalAmount = hourlyRate;
          } else {
            hourlyRate = 40.0;
            totalAmount = hourlyRate + 20.0 * (hoursBetween - 1);
          }
        } else if (paymentType == "1_day_pass") {
          totalAmount = 400.0;
        }
      } else if (widget.vehicleType == "bike") {
        if (paymentType == "regular") {
          hoursBetween = widget.checkOutDateTime!.difference(widget.checkInDateTime!).inHours;
          if (hoursBetween == 24) {
            totalAmount = 250.0;
          } else if (hoursBetween == 1) {
            hourlyRate = 20.0;
            totalAmount = hourlyRate;
          } else {
            hourlyRate = 20.0;
            totalAmount = hourlyRate + 10.0 * (hoursBetween - 1);
          }
        } else if (paymentType == "1_day_pass") {
          totalAmount = 200.0;
        }
      }
    } catch (e) {
      // Handle exceptions (e.g., display an error message)
      print('Error calculating total amount: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Offer payment options based on vehicle type
            if (widget.vehicleType == "car" || widget.vehicleType == "bike")
              Column(
                children: <Widget>[
                  Text('Choose Payment Type:'),
                  Radio(
                    value: "regular",
                    groupValue: paymentType,
                    onChanged: (String? value) {
                      setState(() {
                        paymentType = value!;
                        _calculateTotalAmount();
                      });
                    },
                  ),
                  Text('Regular'),
                  Radio(
                    value: "1_day_pass",
                    groupValue: paymentType,
                    onChanged: (String? value) {
                      setState(() {
                        paymentType = value!;
                        _calculateTotalAmount();
                      });
                    },
                  ),
                  Text('1 Day Pass'),
                ],
              ),
            // Display the total payment amount
            Text('Total Amount: Rs. ${totalAmount.toStringAsFixed(2)}'),
            // Next button to open the fourth page
            ElevatedButton(
              onPressed: () {
                try {
                  if (widget.checkInDateTime == null ||
                      widget.checkOutDateTime == null) {
                    throw Exception("Please select check-in and check-out times");
                  }
                  _calculateTotalAmount();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FourthPage(
                        paymentType: paymentType,
                        carNumber: widget.carNumber,
                        checkInDateTime: widget.checkInDateTime!,
                        checkOutDateTime: widget.checkOutDateTime!,
                        totalAmount: totalAmount,
                      ),
                    ),
                  );
                } catch (e) {
                  // Handle exceptions (e.g., show error dialog)
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text(e.toString()),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Next'),
            ),
            // Back button to navigate back
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}








