import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput(
      {super.key,
      required this.label,
      required this.icon,
      required this.ctrl,
      this.obscText});

  final String label;
  final Icon icon;
  final TextEditingController ctrl;
  final bool? obscText;

  @override
  Widget build(BuildContext context) {
    return TextField(
        obscureText: obscText ?? false,
        controller: ctrl,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            hintText: label,
            hintStyle: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.grey,
            ),
            suffixIcon: icon,
            suffixIconColor: Color(0xFF4163CD),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: BorderSide(color: Color(0xFF4163CD))),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32))));
  }
}
