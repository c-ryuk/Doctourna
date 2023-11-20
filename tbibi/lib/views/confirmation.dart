import 'package:flutter/material.dart';
import 'package:tbibi/widgets/signbutton.dart';

class ConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/done.gif'),
                width: 300,
              ),
              SizedBox(height: 20.0),
              Text(
                'Thank You!',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'),
              ),
              SizedBox(height: 10.0),
              Text(
                'Your registration request has been received. '
                'Please check your email for further instructions.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0, fontFamily: 'Poppins'),
              ),
              SizedBox(height: 20.0),
              SignButton(
                  text: "Okay",
                  textColor: Colors.white,
                  backgroundColor: Color(0xFF4163CD),
                  function: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  })
            ],
          ),
        ),
      ),
    );
  }
}
