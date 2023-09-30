import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  const InputText({
    required this.hint,
    super.key,
  });
  final String hint;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 320,
        child: TextField(
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
          decoration: InputDecoration(
              hintStyle: TextStyle(color: Color(0xFFB1B3C1)),
              hintText: hint,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFB1B3C1))),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white))),
        ));
  }
}
