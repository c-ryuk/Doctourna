import 'package:flutter/material.dart';

import '../widgets/signbutton.dart';
import '../widgets/textinput.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Sign Up",
          style: TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontFamily: 'Poppins Medium',
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
          child: Column(
        children: [
          Expanded(
              flex: 3,
              child: Container(
                color: Colors.white38,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InputText(hint: "First Name"),
                    InputText(
                      hint: "Last Name",
                    ),
                    InputText(
                      hint: "Email",
                    ),
                    InputText(
                      hint: "Password",
                    ),
                    InputText(
                      hint: "Confirm Password",
                    ),
                    SignButton(
                        text: "SIGN UP",
                        textColor: Colors.white,
                        backgroundColor: Color(0xFF4CE3B1),
                        function: () {})
                  ],
                ),
              )),
          Expanded(
              child: Container(
            width: double.infinity,
            color: Color(0xFF4163CD),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Are you a doctor ?",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "More than 100 patients search and find the right doctor for us each month.",
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Join Now",
                    style: TextStyle(
                        fontSize: 22,
                        color: Color(0xFF4163CD),
                        fontFamily: 'Poppins Medium',
                        fontWeight: FontWeight.w500),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))))
            ]),
          ))
        ],
      )),
    );
  }
}
