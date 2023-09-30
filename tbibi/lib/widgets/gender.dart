import 'package:flutter/material.dart';
import 'package:tbibi/models/gender.dart';

class GenderWidget extends StatelessWidget {
  GenderWidget({required this.gender});
  final Gender gender;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      height: 130,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          gender.icon,
          Text(
            gender.title,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 33,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
