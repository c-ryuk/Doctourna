import 'package:flutter/material.dart';
import 'package:tbibi/models/gender.dart';

class GenderWidget extends StatefulWidget {
  GenderWidget({required this.gender, required this.toHide});

  VoidCallback toHide;
  final Gender gender;

  @override
  GenderWidgetState createState() => GenderWidgetState();
}

class GenderWidgetState extends State<GenderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      height: 130,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: GestureDetector(
        onTap: () {
          setState(() {
            widget.toHide();
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            widget.gender.icon,
            Text(
              widget.gender.title,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 33,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
