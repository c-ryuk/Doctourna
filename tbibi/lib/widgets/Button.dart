import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    required this.text,
    required this.function,
  });

  final String text;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function, // Call the function when the button is pressed
      style: ElevatedButton.styleFrom(
        primary: Colors.lightGreen,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 5,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
