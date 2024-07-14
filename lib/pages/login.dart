import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:loginassegmnt/pages/SignUp.dart';
import '../utility/buttonWidget.dart';
import '../utility/imagewidget.dart';
import '../utility/mytextfield.dart';
import '../utility/mytext.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool _showSplash = true;
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

  void signIn() async {
    final url = Uri.parse('http://localhost:3000/api/customers'); // Adjust the URL for your API

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': _emailController.text,
          'username': _usernameController.text,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Navigator.pushReplacementNamed(context, '/HomeScreen', arguments: data);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login successful! Welcome, ${data['username']}!')));
      } else {
        final errorMessage = jsonDecode(response.body)['message'] ?? 'Login failed.';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _emailController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showSplash
          ? SplashScreen()
          : SafeArea(
              child: ListView(
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
                            decoration: InputDecoration(hintText: 'Email Address'),
                          ),
                          SizedBox(height: 30),
                          MyTextField(
                            hintText: 'Username',
                            prefixIcon: Icon(Icons.person),
                            myController: _usernameController,
                            decoration: InputDecoration(hintText: 'Username'),
                          ),
                          SizedBox(height: 30),
                          MyButton(
                            onTap: signIn,
                            btnText: 'Login',
                          ),
                          SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'New User Please? ',
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