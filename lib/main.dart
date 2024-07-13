import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart'; // Import Device Preview package
import 'package:firebase_core/firebase_core.dart';
import 'package:loginassegmnt/pages/authstate.dart';
import 'package:loginassegmnt/firebase_options.dart'; // Make sure to import firebase_options.dart

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  runApp(
    DevicePreview(
      builder: (context) => MyApp(), // Wrap MyApp with DevicePreview
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: DevicePreview.appBuilder, // Enable device preview builder
      locale: DevicePreview.locale(context), // Add this line to support localization
      // Specify your app's home or initial route
      home: AuthState(),
    );
  }
}
