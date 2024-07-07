// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
class CustomTextForm extends StatelessWidget {
  final String hinttext;
  final TextEditingController mycontroller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? obscuringCharacter;
  final String? Function(String?)? validator; // Validator parameter

  const CustomTextForm({
    Key? key,
    required this.hinttext,
    required this.mycontroller,
    required this.obscureText,
    this.keyboardType = TextInputType.text,
    this.obscuringCharacter,
    this.validator, // Initialize validator
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: mycontroller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
        filled: true,
        fillColor: Color.fromARGB(255, 223, 230, 252),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 184, 200, 255),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      obscuringCharacter: obscuringCharacter ?? '•', // Use '•' if null
      validator: validator, // Apply validator
    );
  }
}
