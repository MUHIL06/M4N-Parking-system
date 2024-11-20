import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled6/pages/fifth_page.dart';

class FourthPage extends StatefulWidget {
  final String paymentType;
  final String carNumber;
  final DateTime? checkInDateTime;
  final DateTime? checkOutDateTime;
  final double totalAmount;

  FourthPage({
    required this.paymentType,
    required this.carNumber,
    required this.checkInDateTime,
    required this.checkOutDateTime,
    required this.totalAmount,
  });

  @override
  _FourthPageState createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  String upiID = "";
  String phoneNumber = "";
  String screenShot = "";
  String selectedPaymentOption = "";

  String upiError = "";
  String phoneError = "";
  String screenshotError = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Total Amount: Rs. ${widget.totalAmount.toStringAsFixed(2)}'),
            Text('if UPI Transaction UPI_no is 9150670336'),
            ElevatedButton(
              onPressed: () {
                _showPaymentOptionsDialog();
              },
              child: Text('Payment Option'),
            ),
            if (selectedPaymentOption == 'UPI-ID')
              Column(
                children: [
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        upiID = value;
                        upiError = "";
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter UPI ID',
                      errorText: upiError.isNotEmpty ? upiError : null,
                    ),
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        phoneNumber = value;
                        phoneError = "";
                      });
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Enter Phone Number',
                      errorText: phoneError.isNotEmpty ? phoneError : null,
                    ),
                  ),
                  _buildScreenshotUploader(),
                ],
              ),
            if (selectedPaymentOption == 'g-pay')
              Column(
                children: [
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        upiID = value;
                        upiError = "";
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter UPI ID',
                      errorText: upiError.isNotEmpty ? upiError : null,
                    ),
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        phoneNumber = value;
                        phoneError = "";
                      });
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Enter gpay Number',
                      errorText: phoneError.isNotEmpty ? phoneError : null,
                    ),
                  ),
                  _buildScreenshotUploader(),
                ],
              ),
            if (selectedPaymentOption == 'cash')
              Text(
                'Show the screenshot of the parking slot to the watchman and make the payment.',
              ),
            if (screenShot.isNotEmpty)
              Column(
                children: [
                  Text('Selected Screenshot:'),
                  Image.file(
                    File(screenShot),
                    height: 100.0,
                    width: 100.0,
                  ),
                ],
              ),
            // Next button to open the fifth page
            ElevatedButton(
              onPressed: () {
                if (_validateInputs()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FifthPage(
                        carNumber: widget.carNumber,
                      ),
                    ),
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

  Widget _buildScreenshotUploader() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            _askToUploadScreenshot();
          },
          child: Text('Proceed'),
        ),
      ],
    );
  }

  bool _validateInputs() {
    bool isValid = true;

    if (selectedPaymentOption == 'UPI-ID') {
      if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(upiID)) {
        setState(() {
          upiError = "Enter a valid UPI ID";
        });
        isValid = false;
      }
    }

    if (phoneNumber.length != 10) {
      setState(() {
        phoneError = "Phone number must be 10 digits";
      });
      isValid = false;
    }

    if (screenShot.isEmpty) {
      setState(() {
        screenshotError = "Please upload a screenshot";
      });
      isValid = false;
    }

    return isValid;
  }

  void _showPaymentOptionsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Payment Option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('G-Pay'),
                leading: Radio(
                  value: 'g-pay',
                  groupValue: selectedPaymentOption,
                  onChanged: (value) {
                    setState(() {
                      selectedPaymentOption = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('Cash'),
                leading: Radio(
                  value: 'cash',
                  groupValue: selectedPaymentOption,
                  onChanged: (value) {
                    setState(() {
                      selectedPaymentOption = value!;
                    });
                  },
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _askToUploadScreenshot() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Upload Screenshot'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Please upload a screenshot of the transaction.'),
                  if (screenShot.isNotEmpty)
                    Column(
                      children: [
                        Text('Selected Screenshot:'),
                        Image.file(
                          File(screenShot),
                          height: 100.0,
                          width: 100.0,
                        ),
                      ],
                    ),
                  ElevatedButton(
                    onPressed: () async {
                      await _uploadImage();
                      Navigator.of(context).pop(); // Close the screenshot upload dialog
                    },
                    child: Text('Upload Screenshot'),
                  ),
                ],
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _uploadImage() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        // You can now use pickedFile.path to get the path of the selected image
        // Handle the image upload logic here
        setState(() {
          screenShot = pickedFile.path;
        });
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }
}
