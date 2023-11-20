import 'package:flutter/material.dart';
import '../services/authentication_service.dart';

class LoginWithGoogleButton extends StatelessWidget {
  const LoginWithGoogleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        AuthenticationService().loginWithGoogle(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage("assets/google.png"),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Google",
            style: TextStyle(
                color: Colors.black, fontFamily: "Poppins", fontSize: 20),
          ),
        ],
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
            side: BorderSide(color: Colors.black)),
        fixedSize: Size(310, 40),
      ),
    );
  }
}
