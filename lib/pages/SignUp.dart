import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utility/MyTextField.dart';
import '../utility/buttonWidget.dart';
import '../utility/imagewidget.dart';
import '../utility/mytext.dart';
import 'package:loginassegmnt/pages/home_screen.dart'; // Import HomeScreen
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Import secure storage package

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _storage = FlutterSecureStorage(); // Create an instance of secure storage

  Future<void> signUp() async {
  final url = Uri.parse('http://192.168.43.170:5000/api/auth/register');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': _nameController.text,
        'phone': _telephoneController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
      }),
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      final userId = responseData['data']['id']; // Extract userId from response data

      // Store userId securely using Flutter Secure Storage
      await _storage.write(key: 'userId', value: userId);

      // Log user details to terminal
      print('User registered successfully:');
      print('Name: ${_nameController.text}');
      print('Email: ${_emailController.text}');
      print('UserId: $userId');

      // Successfully signed up, navigate to HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            username: _nameController.text,
            email: _emailController.text,
          ),
        ),
      );

      // Show sign-up successful message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign Up successful!')),
      );
    } else {
      // Show error message if sign-up fails
      final errorMessage = jsonDecode(response.body)['message'] ?? 'Sign Up failed.';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  } catch (e) {
    // Show error message if an exception occurs
    print('Error during sign up: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: ${e.toString()}')),
    );
  }
}


  @override
  void dispose() {
    _nameController.dispose();
    _telephoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
                  myController: _nameController,
                ),
                SizedBox(height: 20),
                MyTextField(
                  hintText: 'Your Telephone Number',
                  prefixIcon: Icon(Icons.phone),
                  myController: _telephoneController,
                ),
                SizedBox(height: 20),
                MyTextField(
                  hintText: 'Your Email Address',
                  prefixIcon: Icon(Icons.alternate_email_outlined),
                  myController: _emailController,
                ),
                SizedBox(height: 20),
                MyTextField(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  isPassword: true, // Set isPassword to true for the password field
                  myController: _passwordController,
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
                        Navigator.pushReplacementNamed(context, '/login'); // Navigate to login page
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
