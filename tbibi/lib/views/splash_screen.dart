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
    delayedPage();
  }

  delayedPage() async {
    return await Future.delayed(Duration(seconds: 3), () {
      return Navigator.of(context).pushReplacementNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return LunchingPage();
  }
}
