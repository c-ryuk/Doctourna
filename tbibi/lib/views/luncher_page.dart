import 'package:flutter/material.dart';

class LunchingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Expanded(
              child:
                  Image(image: AssetImage("assets/doctourna_lunch_page.png")))),
    );
  }
}
