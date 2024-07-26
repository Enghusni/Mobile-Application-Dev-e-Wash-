import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../pages/SignUp.dart';
import '../utility/buttonWidget.dart';
import '../utility/imagewidget.dart';
import '../utility/MyTextField.dart';
import '../utility/mytext.dart';
import '../pages/home_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterSecureStorage _storage = FlutterSecureStorage();

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showSplash = true;
  bool _isLoading = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showSplash = false;
        });
      }
    });
  }

Future<void> login() async {
  final url = Uri.parse('http://192.168.43.170:5000/api/auth/login');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': _emailController.text,
        'password': _passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print('Login Response Data: $responseData');

      if (responseData.containsKey('data')) {
        final userId = responseData['data']['id']; // Extract userId from response data

        // Print user details to the terminal
        print('User logged in successfully:');
        print('Name: ${responseData['data']['name']}');
        print('Email: ${responseData['data']['email']}');
        print('UserId: $userId');

        // Navigate to HomeScreen or any other authenticated screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              username: responseData['data']['name'], // Pass username if needed
              email: responseData['data']['email'],
            ),
          ),
        );

        // Show login successful message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Logged in successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: Unexpected response structure')),
        );
      }
    } else {
      // Show error message if login fails
      final errorMessage = jsonDecode(response.body)['message'] ?? 'Login failed.';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  } catch (e) {
    // Show error message if an exception occurs
    print('Error during login: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: ${e.toString()}')),
    );
  }
}



  @override
  void dispose() {
    _timer?.cancel();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showSplash
          ? SplashScreen()
          : SafeArea(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ListView(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipOval(
                            child: Container(
                              width: double.infinity,
                              child: ImageWidget(
                                ImageAsset: 'images/mylogin.png',
                                ImageHeight: 250,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 25, right: 25),
                        child: Container(
                          width: double.infinity,
                          height: 400,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: MyText(
                                  MylableText: 'Login',
                                  FontSize: 40,
                                ),
                              ),
                              SizedBox(height: 30),
                              MyTextField(
                                hintText: 'Email Address',
                                prefixIcon: Icon(Icons.alternate_email_outlined),
                                myController: _emailController,
                              ),
                              SizedBox(height: 30),
                              MyTextField(
                                hintText: 'Password',
                                prefixIcon: Icon(Icons.lock_outline),
                                myController: _passwordController,
                                isPassword: true,
                              ),
                              SizedBox(height: 30),
                              _isLoading
                                  ? CircularProgressIndicator()
                                  : MyButton(
                                      onTap: login,
                                      btnText: 'Login',
                                    ),
                              SizedBox(height: 40),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Create New User? ',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignUp(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Register',
                                      style: TextStyle(
                                        fontSize: 20,
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
                    ],
                  ),
                  if (_isLoading)
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                ],
              ),
            ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4713A3),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/Capture.PNG',
              height: 300,
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
