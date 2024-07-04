import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loginassegmnt/pages/home_screen.dart';
import 'package:loginassegmnt/pages/login.dart';

class AuthState extends StatelessWidget {
  const AuthState({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Loading indicator while checking authentication state
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          // Checking if user is authenticated or not
          if (snapshot.hasData && snapshot.data != null) {
            // User is authenticated, navigate to home screen
            return HomeScreen(
              username: snapshot.data!.displayName ?? '',
              email: snapshot.data!.email ?? '',
            );
          } else {
            // User is not authenticated, navigate to login screen
            return LoginPage();
          }
        }
      },
    );
  }
}
