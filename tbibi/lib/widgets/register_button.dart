import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    required this.function,
    required this.password,
    required this.confirmPassword,
  });

  final String text;
  final Color textColor;
  final Color backgroundColor;
  final VoidCallback function;
  final String password;
  final String confirmPassword;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: confirmPassword != password ? null : function,
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
