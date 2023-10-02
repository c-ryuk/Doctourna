import 'package:flutter/material.dart';
import 'package:tbibi/views/signup_page.dart';
import 'package:tbibi/widgets/signbutton.dart';
import 'package:tbibi/widgets/textinput.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 800,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      child: Image.asset(
                        "assets/login_image.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: double.infinity,
                      color: Color(0xFF4163CD),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InputText(hint: "Email"),
                          InputText(hint: "Password"),
                          SizedBox(
                            height: 26,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 125),
                            child: Text(
                              "Forgot your password ?",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontSize: 17,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SignButton(
                            text: "LOGIN",
                            textColor: Colors.white,
                            backgroundColor: Color(0xFF4CE3B1),
                            function: () {},
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "New Member ?",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return SignUpPage();
                              }));
                            },
                            child: Text(
                              "SIGN IN",
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(310, 40),
                              backgroundColor: Color(0xFF4163CD),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.white,
                                  width: 1.0,
                                ),
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
              Positioned(
                top: 30,
                left: 20,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
