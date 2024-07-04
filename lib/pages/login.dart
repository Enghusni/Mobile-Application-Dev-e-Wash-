import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginassegmnt/pages/SignUp.dart';
import 'package:loginassegmnt/utility/buttonWidget.dart';
import 'package:loginassegmnt/utility/imagewidget.dart';
import 'package:loginassegmnt/utility/Mytextfield.dart';
import 'package:loginassegmnt/utility/mytext.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    // Wait for 3 seconds before showing login screen
    Timer(Duration(seconds: 3), () {
      setState(() {
        _showSplash = false;
      });
    });
  }

  void signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showSplash
          ? SplashScreen() // Show SplashScreen if _showSplash is true
          : SafeArea(
              child: ListView(
                children: [
                  // Circular Image
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
                      height: 500,
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
                            decoration: InputDecoration(
                              hintText: 'Email ID',
                              prefixIcon: Icon(Icons.alternate_email_outlined),
                            ),
                            myController: _emailController,
                            hintText: 'Email address',
                            prefixIcon: Icon(Icons.alternate_email_outlined),
                          ),
                          SizedBox(height: 30),
                          MyTextField(
                            decoration: InputDecoration(
                              hintText: 'Password',
                              prefixIcon: Icon(Icons.lock),
                              suffixText: 'Forget?',
                              suffixStyle: TextStyle(
                                color: Color(0xFF4713A3),
                                fontSize: 18,
                              ),
                            ),
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            myController: _passwordController,
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
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: ((context) => SignUp()),
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
      backgroundColor: Color(0xFF4713A3), // Set background color to purple for splash screen
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo here
            Image.asset(
              'images/Capture.PNG',
              height: 300,
            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
