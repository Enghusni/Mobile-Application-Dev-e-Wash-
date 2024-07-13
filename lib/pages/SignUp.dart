import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:loginassegmnt/pages/login.dart';

import '../utility/Mytextfield.dart';
import '../utility/buttonWidget.dart';
import '../utility/imagewidget.dart';
import '../utility/mytext.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _yourname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _telephone = TextEditingController();

  void signUp() async {
    final url = Uri.parse('http://localhost:3000/api/customers'); // Adjust this URL

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': _yourname.text,
          'email': _email.text,
          'phone': _telephone.text,
        }),
      );

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        final errorMessage = jsonDecode(response.body)['message'] ?? 'Signup failed.';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  @override
  void dispose() {
    _yourname.dispose();
    _email.dispose();
    _telephone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageWidget(
                  ImageAsset: 'images/mylogin.png',
                  ImageHeight: 250,
                ),
                SizedBox(height: 20),
                Center(
                  child: MyText(
                    MylableText: 'Sign Up',
                    FontSize: 30,
                  ),
                ),
                SizedBox(height: 20),
                MyTextField(
                  hintText: 'Your Name',
                  prefixIcon: Icon(Icons.person),
                  myController: _yourname,
                  decoration: InputDecoration(hintText: 'Your Name'),
                ),
                SizedBox(height: 20),
                MyTextField(
                  hintText: 'Your Email Address',
                  prefixIcon: Icon(Icons.alternate_email_outlined),
                  myController: _email,
                  decoration: InputDecoration(hintText: 'Your Email Address'),
                ),
                SizedBox(height: 20),
                MyTextField(
                  hintText: 'Your Telephone Number',
                  prefixIcon: Icon(Icons.phone),
                  myController: _telephone,
                  decoration: InputDecoration(hintText: 'Your Telephone Number'),
                ),
                SizedBox(height: 20),
                MyButton(
                  onTap: signUp,
                  btnText: 'Sign Up',
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF4713A3),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
