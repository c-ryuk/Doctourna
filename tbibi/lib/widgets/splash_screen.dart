import 'package:flutter/material.dart';
import 'package:tbibi/views/luncher_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    delayedPage(); // Démarre la temporisation et la transition
  }

  delayedPage() async {
    return await Future.delayed(Duration(seconds: 8), () {
      return Navigator.of(context).pushReplacementNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return LunchingPage();
  }
}
