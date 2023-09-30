import 'package:flutter/material.dart';

class SignButton extends StatelessWidget {
  const SignButton({
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    required this.function,
  });

  final String text;
  final Color textColor;
  final Color backgroundColor;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(
              fontSize: 22,
              color: textColor,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500),
        ),
        style: ElevatedButton.styleFrom(
            fixedSize: Size(310, 40),
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )));
  }
}
