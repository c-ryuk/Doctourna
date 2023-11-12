import 'package:flutter/material.dart';
import 'package:tbibi/services/authentication_service.dart';
import 'package:tbibi/views/gender_page.dart';
import '../widgets/register_button.dart';
import '../widgets/signbutton.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController fullName = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController cpassword = TextEditingController();

  vrify() {
    if (cpassword.text != password.text) {
      return null;
    }
  }

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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 300, // Set the desired width here
                        child: TextFormField(
                          controller: fullName,
                          decoration: InputDecoration(
                            labelText: "Full Name",
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                      ),
                      Container(
                        width: 300, // Set the desired width here
                        child: TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                      ),
                      Container(
                        width: 300, // Set the desired width here
                        child: TextFormField(
                          controller: password,
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: Icon(Icons.lock),
                          ),
                          obscureText: true,
                        ),
                      ),
                      Container(
                        width: 300, // Set the desired width here
                        child: TextFormField(
                          onChanged: (value) {
                            if (value != password.text) {
                              print("not comp");
                            } else {
                              print("comp");
                            }
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
                          AuthenticationService().createAccount(
                              emailAddress: email.text,
                              password: password.text,
                              username: fullName.text,
                              context: context);

                          AuthenticationService().checkUserStatus();
                        },
                      )
                    ],
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
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return GenderPage();
                          }));
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
