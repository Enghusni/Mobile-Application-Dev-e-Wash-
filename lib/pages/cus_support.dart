import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';  // For JSON encoding

class CustomerSupportScreen extends StatefulWidget {
  @override
  _CustomerSupportScreenState createState() => _CustomerSupportScreenState();
}

class _CustomerSupportScreenState extends State<CustomerSupportScreen> {
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  String _nameErrorText = '';
  String _numberErrorText = '';
  String _subjectErrorText = '';
  String _messageErrorText = '';
  bool _isLoading = false;

  void _validateInputs() {
    setState(() {
      _nameErrorText =
          _nameController.text.isEmpty ? 'Please enter your name' : '';
      _numberErrorText =
          _numberController.text.isEmpty ? 'Please enter your number' : '';
      _subjectErrorText =
          _subjectController.text.isEmpty ? 'Please enter your Subject' : '';
      _messageErrorText =
          _messageController.text.isEmpty ? 'Please enter your message' : '';

      if (_numberErrorText == '' && _numberController.text.isNotEmpty) {
        try {
          int.parse(_numberController.text);
        } catch (e) {
          _numberErrorText = 'Please enter a valid number';
        }
      }

      if (_nameErrorText == '' &&
          _numberErrorText == '' &&
          _subjectErrorText == '' &&
          _messageErrorText == '') {
        _submitSupportRequest();
      }
    });
  }

  Future<void> _submitSupportRequest() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
      Uri.parse('https://localhost:3000/api/customer-care'),  // Replace with your API endpoint
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': _nameController.text,
        'number': _numberController.text,
        'subject': _subjectController.text,
        'message': _messageController.text,
      }),
    );

    if (response.statusCode == 200) {
      _showConfirmationDialog();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit request. Please try again.')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '🎉 Thank you for your patience. A member of our team will get back to you shortly. 🎉',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('OK', style: TextStyle(color: Colors.white, fontSize: 20)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4713A3),
                  minimumSize: Size(120, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4713A3),
        title: Text(
          'Customer Support',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 15.0),
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0.3,
                    blurRadius: 0.1,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'images/mylogin2.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'WELCOME BACK !',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Thank you for choosing e-Wash',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Enter Your FullName',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: Color(0xFF4713A3)),
                ),
                errorText: _nameErrorText,
              ),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _numberController,
              decoration: InputDecoration(
                labelText: 'Enter Your Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: Color(0xFF4713A3)),
                ),
                errorText: _numberErrorText,
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _subjectController,
              decoration: InputDecoration(
                labelText: 'Enter Your Subject',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: Color(0xFF4713A3)),
                ),
                errorText: _subjectErrorText,
              ),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: 'Your feedback helps us to serve you better',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: Color(0xFF4713A3)),
                ),
                errorText: _messageErrorText,
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading || _nameErrorText != '' || _numberErrorText != '' || _subjectErrorText != '' || _messageErrorText != ''
                    ? null
                    : _validateInputs,
                child: Text(
                  _isLoading ? 'Submitting...' : 'SUBMIT',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4713A3),
                  minimumSize: Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: CustomerSupportScreen(),
  ));
}
