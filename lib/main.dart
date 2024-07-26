import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart'; // Import Device Preview package
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil package
import 'package:loginassegmnt/pages/signup.dart'; // Import SignUp screen
import 'package:loginassegmnt/pages/home_screen.dart'; // Import HomeScreen screen
import 'package:loginassegmnt/pages/login.dart'; // Import LoginScreen screen

void main() {
  runApp(
    DevicePreview(
      builder: (context) => MyApp(), // Wrap MyApp with DevicePreview
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false, // Remove debug banner in release mode
        locale: DevicePreview.locale(context), // Add this line to support localization
        builder: DevicePreview.appBuilder, // Enable device preview builder
        initialRoute: '/signup', // Specify the initial route
        routes: {
          '/signup': (context) => SignUp(), // SignUp screen route
          '/home': (context) => HomeScreen(username: '', email: ''), // HomeScreen route with initial values
          '/login': (context) => LoginPage(), // Login screen route
        },
      ),
    );
  }
}
