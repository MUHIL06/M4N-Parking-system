import 'package:flutter/material.dart';
import 'package:untitled6/pages/third_page.dart';

// Function to validate car/bike number format
bool validateCarNumber(String value) {
  RegExp carNumberRegExp = RegExp(r'^[a-zA-Z]{2}\d{2}[a-zA-Z]{2}\d{4}$');
  return carNumberRegExp.hasMatch(value);
}

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  String vehicleType = "car"; // Default vehicle type
  String carNumber = ""; // Car number input
  DateTime? checkInDateTime; // Selected check-in date and time
  DateTime? checkOutDateTime; // Selected check-out date and time

  // Function to update the check-in date and time
  void _updateCheckInDateTime(DateTime dateTime) {
    setState(() {
      checkInDateTime = dateTime;
    });
  }

  // Function to update the check-out date and time
  void _updateCheckOutDateTime(DateTime dateTime) {
    setState(() {
      checkOutDateTime = dateTime;
    });
  }

  // Validate car/bike number format
  String? validateCarNumberFormat(String value) {
    if (!validateCarNumber(value)) {
      return 'Please enter a valid car/bike number (e.g., AB12CD3456)';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Choose Vehicle Type:'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Radio(
                  value: "car",
                  groupValue: vehicleType,
                  onChanged: (String? selectedValue) {
                    setState(() {
                      vehicleType = selectedValue!;
                    });
                  },
                ),
                Text('Car'),
                Radio(
                  value: "bike",
                  groupValue: vehicleType,
                  onChanged: (String? selectedValue) {
                    setState(() {
                      vehicleType = selectedValue!;
                    });
                  },
                ),
                Text('Bike'),
              ],
            ),
            // Input field for car number
            TextFormField(
              onChanged: (value) {
                setState(() {
                  carNumber = value;
                });
              },
              validator: (value) {
                return validateCarNumberFormat(value!);
              },
              decoration: InputDecoration(
                labelText: 'Car/Bike Number',
              ),
            ),
            // Select check-in date and time
            ElevatedButton(
              onPressed: () async {
                try {
                  final selectedDateTime = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (selectedDateTime != null) {
                    final selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(selectedDateTime),
                    );
                    if (selectedTime != null) {
                      _updateCheckInDateTime(
                        DateTime(
                          selectedDateTime.year,
                          selectedDateTime.month,
                          selectedDateTime.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        ),
                      );
                    }
                  }
                } catch (e) {
                  // Handle exceptions (e.g., if the user closes the date picker)
                  print('Error selecting check-in date and time: $e');
                }
              },
              child: Text('Select Check-In Date & Time'),
            ),
            // Select check-out date and time
            ElevatedButton(
              onPressed: () async {
                try {
                  final selectedDateTime = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (selectedDateTime != null) {
                    final selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(selectedDateTime),
                    );
                    if (selectedTime != null) {
                      _updateCheckOutDateTime(
                        DateTime(
                          selectedDateTime.year,
                          selectedDateTime.month,
                          selectedDateTime.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        ),
                      );
                    }
                  }
                } catch (e) {
                  // Handle exceptions (e.g., if the user closes the date picker)
                  print('Error selecting check-out date and time: $e');
                }
              },
              child: Text('Select Check-Out Date & Time'),
            ),
            // Display selected check-in and check-out times
            if (checkInDateTime != null && checkOutDateTime != null)
              Column(
                children: <Widget>[
                  Text('Selected Check-In Time: ${checkInDateTime.toString()}'),
                  Text('Selected Check-Out Time: ${checkOutDateTime.toString()}'),
                ],
              ),
            // Next button to open the third page
            ElevatedButton(
              onPressed: () {
                try {
                  if (checkInDateTime == null || checkOutDateTime == null) {
                    throw Exception("Please select check-in and check-out times");
                  }
                  if (validateCarNumber(carNumber) != true) {
                    throw Exception("Please enter a valid car/bike number");
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ThirdPage(
                        vehicleType: vehicleType,
                        carNumber: carNumber,
                        checkInDateTime: checkInDateTime!,
                        checkOutDateTime: checkOutDateTime!,
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
