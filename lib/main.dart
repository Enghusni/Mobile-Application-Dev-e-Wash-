import 'package:flutter/material.dart';
import 'package:loginassegmnt/pages/authstate.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loginassegmnt/firebase_options.dart'; // Make sure to import firebase_options.dart


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp()); // Call runApp with an instance of MyApp
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      home: AuthState(),
    );
  }
}
