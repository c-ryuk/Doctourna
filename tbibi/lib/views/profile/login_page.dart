import 'package:flutter/material.dart';
import 'package:tbibi/services/authentication_service.dart';
import 'package:tbibi/views/profile/signup_page.dart';
import 'package:tbibi/widgets/login_google_button.dart';
import 'package:tbibi/widgets/signbutton.dart';
import 'package:tbibi/widgets/textinput.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login",
            style: TextStyle(
                fontFamily: 'Poppins Medium',
                color: Color(0xFF4163CD),
                fontSize: 22)),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Color(0xFF4163CD), // Replace with your custom icon
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 730,
          child: Column(
            children: [
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
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextInput(
                          label: "Email",
                          icon: Icon(Icons.mail),
                          ctrl: email,
                          validator: (value) {
                            String pattern =
                                r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
                            RegExp regExp = RegExp(pattern);

                            if (value == null || value.isEmpty) {
                              return 'Please enter your email address.';
                            }

                            if (!regExp.hasMatch(value)) {
                              return 'Invalid email address.';
                            }

                            return null;
                          },
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        TextInput(
                          label: "Password",
                          icon: Icon(Icons.password_rounded),
                          ctrl: password,
                          obscText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password.';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        isTapped
                            ? CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Color(0xFF4163CD),
                              )
                            : Padding(
                                padding: EdgeInsets.only(left: 180),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/reset_password');
                                  },
                                  child: Text(
                                    "Forgot your password ?",
                                    style: TextStyle(
                                      color: Color(0xFF4163CD),
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 7,
                        ),
                        SignButton(
                          text: "LOGIN",
                          textColor: Colors.white,
                          backgroundColor: Color(0xFF4163CD),
                          function: () async {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                isTapped = true;
                              });
                              try {
                                await AuthenticationService().login(
                                  emailAddress: email.text,
                                  password: password.text,
                                  context: context,
                                );
                              } finally {
                                setState(() {
                                  isTapped = false;
                                });
                              }
                            }
                          },
                        ),
                        SizedBox(
                          height: 5,
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
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
