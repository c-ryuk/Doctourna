import 'package:flutter/material.dart';

class LunchingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Expanded(
                child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(image: AssetImage("assets/doctourna_lunch_page.png")),
        SizedBox(
          height: 20,
        ),
        Transform.scale(
          scale: 1.5,
          child: CircularProgressIndicator(
            backgroundColor: Colors.black,
            color: Color(0xFF4163CD),
            strokeWidth: 2,
          ),
        ),
      ],
    ))));
  }
}
