import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginassegmnt/pages/login.dart';

import '../utility/Mytextfield.dart';
import '../utility/buttonWidget.dart';
import '../utility/imagewidget.dart';
import '../utility/mytext.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirm = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void showErr(msg) {
      showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: AlertDialog(
              title: Text(msg),
            ),
          );
        },
      );
    }

    void singUp() async {
      if (_password.text == _confirm.text) {
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _email.text,
            password: _password.text,
          );
          // After creating the user, you can also update the user's profile to include the username
          await FirebaseAuth.instance.currentUser!.updateDisplayName(_username.text);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            showErr('The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            showErr('The account already exists for that email.');
          }
        } catch (e) {
          print(e);
        }
      } else {
        showErr('Password mismatch');
      }
    }

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
                  hintText: 'Username',
                  prefixIcon: Icon(Icons.person),
                  myController: _username,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: 20),
                MyTextField(
                  hintText: 'Email ID',
                  prefixIcon: Icon(Icons.alternate_email_outlined),
                  myController: _email,
                  decoration: InputDecoration(
                    hintText: 'Email ID',
                    prefixIcon: Icon(Icons.alternate_email_outlined),
                  ),
                ),
                SizedBox(height: 20),
                MyTextField(
                  myController: _password,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline_rounded),
                  ),
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock_outline_rounded),
                ),
                SizedBox(height: 20),
                MyTextField(
                  hintText: 'Confirm password',
                  prefixIcon: Icon(Icons.lock_clock_outlined),
                  myController: _confirm,
                  decoration: InputDecoration(
                    hintText: 'Confirm password',
                    prefixIcon: Icon(Icons.lock_clock_outlined),
                  ),
                ),
                SizedBox(height: 30),
                MyButton(
                  onTap: singUp,
                  btnText: 'Sign Up',
                ),
                SizedBox(height: 20),
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
                            builder: ((context) => LoginPage()),
                          ),
                        );
                      },
                      child: Text(
                        'login',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF4713A3),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
