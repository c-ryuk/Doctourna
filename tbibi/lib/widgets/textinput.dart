import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.label,
    required this.icon,
  });

  final String label;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return TextField(
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
