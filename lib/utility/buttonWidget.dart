
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String btnText;
  final VoidCallback  onTap;
  const MyButton({super.key, required this.btnText,
  required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF4713A3),
          borderRadius: BorderRadius.circular(20),
        ),
        width: double.infinity,
        height: 65,
        child: Center(
            child: Text(
          btnText,
          style: const TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
    );
  }
}
