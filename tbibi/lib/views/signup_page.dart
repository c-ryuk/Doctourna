import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tbibi/services/authentication_service.dart';
<<<<<<< Updated upstream

import '../widgets/register_button.dart';
=======
import 'package:tbibi/views/gender_page.dart';
import 'package:tbibi/widgets/governorats_dropdown.dart';
import 'package:tbibi/widgets/location_builder.dart';
import '../widgets/register_button.dart';
import '../widgets/signbutton.dart';
import 'package:flutter/services.dart';
>>>>>>> Stashed changes

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController fullName = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController cpassword = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController locationController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isEuqal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Register",
          style: TextStyle(
            fontSize: 30,
            color: Color(0xFF4163CD),
            fontFamily: 'Poppins Medium',
            fontWeight: FontWeight.w500,
          ),
        ),
        iconTheme: IconThemeData(color: Color(0xFF4163CD), size: 30),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 728,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 300,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Name should not be empty.';
                              }
                              return null;
                            },
                            controller: fullName,
                            decoration: InputDecoration(
                              labelText: "Full Name",
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                        ),
                        Container(
                          width: 300,
                          child: TextFormField(
                            validator: (value) {
                              String pattern =
                                  r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
                              RegExp regExp = RegExp(pattern);
                              if (value == null || value.isEmpty) {
                                return 'Please enter an email address.';
                              }

                              if (!regExp.hasMatch(value)) {
                                return 'Invalid email address';
                              }

                              return null;
                            },
                            controller: email,
                            decoration: InputDecoration(
                              labelText: "Email",
                              prefixIcon: Icon(Icons.email),
                            ),
                          ),
                        ),
                        Container(
                          width: 300,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            controller: locationController,
                            decoration: InputDecoration(
                              hintText: 'Government,Locality',
                              labelText: "Location",
                              suffixIcon: IconButton(
                                icon: Icon(Icons.location_searching),
                                onPressed: () async {
                                  final locationStatus =
                                      await AuthenticationService()
                                          .requestLocationPermission();
                                  if (locationStatus.isGranted) {
                                    AuthenticationService()
                                        .getCurrentLocation(locationController);
                                  } else {}
                                },
                              ),
                              prefixIcon: Icon(Icons.location_on),
                            ),
                          ),
                        ),
                        Container(
                          width: 300,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            controller: phoneNumberController,
                            decoration: InputDecoration(
                              labelText: "Phone Number",
                              prefixIcon: Icon(Icons.phone),
                            ),
                            keyboardType: TextInputType.phone,
                            maxLength: 8,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                          ),
                        ),
                        Container(
                          width: 300,
                          child: TextFormField(
                            validator: (value) {
                              String pattern =
                                  r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,}$';
                              RegExp regExp = RegExp(pattern);

                              if (value == null || value.isEmpty) {
                                return 'Please enter a password.';
                              }

                              if (!regExp.hasMatch(value)) {
                                return 'Password must contain at least one uppercase letter,\none lowercase letter, and one digit.';
                              }

                              return null;
                            },
                            controller: password,
                            decoration: InputDecoration(
                              labelText: "Password",
                              prefixIcon: Icon(Icons.lock),
                            ),
                            obscureText: true,
                          ),
                        ),
                        Container(
                          width: 300,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password.';
                              }

                              if (value != password.text) {
                                return 'Passwords do not match.';
                              }

                              return null;
                            },
                            controller: cpassword,
                            decoration: InputDecoration(
                              labelText: "Confirm Password",
                              prefixIcon: Icon(Icons.lock),
                            ),
                            obscureText: true,
                          ),
                        ),
                        RegisterButton(
                          password: password.text,
                          confirmPassword: cpassword.text,
                          text: "Register",
                          textColor: Colors.white,
                          backgroundColor: Color(0xFF4163CD),
                          function: () async {
                            if (formKey.currentState!.validate()) {
                              AuthenticationService().createAccount(
                                  emailAddress: email.text,
                                  password: password.text,
                                  username: fullName.text,
                                  phone: phoneNumberController.text,
                                  location: locationController.text,
                                  context: context);

                              AuthenticationService().checkUserStatus();
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  color: Color(0xFF4163CD),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Are you a doctor ?",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
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
                        onPressed: () {
                          Navigator.pushNamed(context, '/select_gender');
                        },
                        child: Text(
                          "Join Now",
                          style: TextStyle(
                            fontSize: 22,
                            color: Color(0xFF4163CD),
                            fontFamily: 'Poppins Medium',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
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
