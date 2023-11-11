import 'package:flutter/material.dart';
import 'package:tbibi/services/authentication_service.dart';
import 'package:tbibi/views/signup_page.dart';
import 'package:tbibi/widgets/signbutton.dart';

import '../widgets/login_google_button.dart';
import '../widgets/textinput.dart';

class LoginPage extends StatelessWidget {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 800,
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Expanded(
                flex: 2,
                child: Image.asset(
                  "assets/female-doctor.png",
                  width: 340,
                  height: 340,
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextInput(
                        label: "Email",
                        icon: Icon(Icons.mail),
                        ctrl: email,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextInput(
                        label: "Password",
                        icon: Icon(Icons.password_rounded),
                        ctrl: password,
                        obscText: true,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 180),
                        child: Text(
                          "Forgot your password ?",
                          style: TextStyle(
                            color: Color(0xFF4163CD),
                            fontFamily: 'Poppins',
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SignButton(
                        text: "LOGIN",
                        textColor: Colors.white,
                        backgroundColor: Color(0xFF4163CD),
                        function: () {
                          AuthenticationService().login(
                              emailAddress: email.text,
                              password: password.text,
                              context: context);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const LoginWithGoogleButton(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account ?",
                              style: TextStyle(fontFamily: 'Poppins'),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return SignUpPage();
                                }));
                              },
                              child: Text(
                                " Register",
                                style: TextStyle(
                                    color: Color(0xFF4163CD),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins'),
                              ),
                            )
                          ])
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
