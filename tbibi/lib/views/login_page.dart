import 'package:flutter/material.dart';
import 'package:tbibi/views/signup_page.dart';
import 'package:tbibi/widgets/signbutton.dart';

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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
                      width: double.infinity,
                      child: Image.asset(
                        "assets/login_doctor.png",
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Email Input
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Email",
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          // Password Input
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Password",
                              prefixIcon: Icon(Icons.lock), // Password icon
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 26,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Forgot your password ?",
                              style: TextStyle(
                                color: Colors.black38,
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
                            backgroundColor: Colors.red,
                            function: () {},
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Or",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black38,
                            ),
                          ),
                          SizedBox(
                            height: 20,
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
                              backgroundColor: Colors.red.withOpacity(0.8),
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
                left: 0,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.red,
                    size: 30,
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
