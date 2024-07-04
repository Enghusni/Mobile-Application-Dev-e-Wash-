import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final Icon prefixIcon;
  final TextEditingController myController;
  MyTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.myController, required InputDecoration decoration,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: myController,
      decoration: InputDecoration(
        hintText: hintText,
         prefixIcon: prefixIcon,
         border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
    ),
         
         ),
    );
  }
}

