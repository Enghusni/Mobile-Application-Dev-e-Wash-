import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});
  void _singut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: _singut, icon: Icon(Icons.logout)),
          ],
        ),
        body: Center(
          child: Text("Welcome To My HomePage Ustaad"),
        ),
      ),
    );
  }
}
