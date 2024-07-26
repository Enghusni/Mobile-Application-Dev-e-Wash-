import 'package:flutter/material.dart';


class CustomerSupportScreen extends StatefulWidget {
  @override
  _CustomerSupportScreenState createState() => _CustomerSupportScreenState();
}

class _CustomerSupportScreenState extends State<CustomerSupportScreen> {
  final _subjectController = TextEditingController();
  final _numberController = TextEditingController();
  final _messageController = TextEditingController();
  String _subjectErrorText = '';
  String _numberErrorText = '';
  String _messageErrorText = '';


  void _validateInputs() {
  setState(() {
    _subjectErrorText = _subjectController.text.isEmpty ? 'Please enter your subject' : '';
    _numberErrorText = _numberController.text.isEmpty ? 'Please enter your number' : '';
    _messageErrorText = _messageController.text.isEmpty ? 'Please enter your message' : '';
    
    if (_numberErrorText == '' && _numberController.text.isNotEmpty) {
      try {
        int.parse(_numberController.text);
      } catch (e) {
        _numberErrorText = 'Please enter a valid number';
      }
    }

    if (_subjectErrorText == '' && _numberErrorText == '' && _messageErrorText == '') {
      // All inputs are valid, you can submit the data
      String subject = _subjectController.text;
      String number = _numberController.text;
      String message = _messageController.text;

      // Here you can handle the submission of the data, e.g., sending it to a server
      print('Subject: $subject');
      print('Number: $number');
      print('Message: $message');
    }
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFF4713A3),
        title: Text('Customer Support', style: TextStyle(color: Colors.white),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back , color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [SizedBox(height: 20.0),
        Container(
  width: 120,
  height: 120,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20), // Apply border radius to all corners
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 0.3,
        blurRadius: 0.1,
        offset: Offset(0, 0), // changes position of shadow
      ),
    ],
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(20), // Clip the child with the same border radius
    child: Image.asset(
      'images/mylogin2.png', // Change to your asset path
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
            SizedBox(height: 20.0),
            TextFormField(
              controller: _subjectController,
              decoration: InputDecoration(
                labelText: 'Enter Your Subject',
                focusColor: Color(0xFF4713A3),
                border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(15.0),
                   borderSide: BorderSide(color: Color(0xFF4713A3)),
                ),
                errorText: _subjectErrorText,
              ),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 10.0),
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
            SizedBox(height: 10.0),
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
  maxLines: 10, // Adjust this value as needed
  minLines: 5,  // Ensures the field has a minimum height
),


            SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _validateInputs,
                child: Text('SUBMIT' , style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 20),),
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF4713A3),minimumSize: Size(double.infinity, 60),
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
    _subjectController.dispose();
    _numberController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: CustomerSupportScreen(),
  ));
}
