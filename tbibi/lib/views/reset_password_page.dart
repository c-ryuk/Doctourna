import 'package:flutter/material.dart';
import 'package:tbibi/services/authentication_service.dart';
import 'package:tbibi/widgets/signbutton.dart';
import '../widgets/textinput.dart';

class ResetPasswordPage extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        centerTitle: true,
        title: Text("Forgot password",
            style: TextStyle(
                fontFamily: 'Poppins Medium', color: Color(0xFF4163CD))),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 725,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Image.asset(
                  "assets/reset.png",
                  // width: 340,
                  // height: 340,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 35),
                        child: Text(
                          "Please enter your registred Email.",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 19),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 35),
                        child: Text(
                          "We will send a reset link to your registred Email.",
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
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
                        height: 10,
                      ),
                      SignButton(
                          text: "Reset Password",
                          textColor: Colors.white,
                          backgroundColor: Color(0xFF4163CD),
                          function: () async {
                            if (formKey.currentState!.validate()) {
                              AuthenticationService()
                                  .resetPassword(email: email.text);
                            }
                          }),
                      SizedBox(
                        height: 40,
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
