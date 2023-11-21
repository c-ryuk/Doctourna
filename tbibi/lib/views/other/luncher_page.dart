import 'package:flutter/material.dart';

class LunchingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Expanded(
          child: Center(
        child: Image(image: AssetImage("assets/doctourna_lunch_page.png")),
      ))
    ]));
  }
}
