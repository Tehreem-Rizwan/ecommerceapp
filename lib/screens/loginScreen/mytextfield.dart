import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;
  final int maxLines;

  MyTextfield({
    this.controller,
    this.hintText,
    this.obscureText = false,
    this.maxLines = 1, // Provide a default value
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines, // Use maxLines directly
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        fillColor: Colors.grey[200],
        filled: true,
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }
}
