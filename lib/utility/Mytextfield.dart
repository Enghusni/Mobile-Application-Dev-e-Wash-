import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final Widget prefixIcon;
  final TextEditingController myController;
  final bool isPassword; // Boolean to determine if this is a password field
  final InputDecoration? decoration; // Nullable decoration parameter

  const MyTextField({
    required this.hintText,
    required this.prefixIcon,
    required this.myController,
    this.isPassword = false, // Default to false (not a password field)
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      obscureText: isPassword, // Obfuscate text if this is a password field
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
