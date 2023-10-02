import 'package:flutter/material.dart';
import 'package:tbibi/models/speciality.dart';

class SpecialityWidget extends StatefulWidget {
  SpecialityWidget(
      {required this.speciality,
      required this.isSelected,
      required this.onTap});

  final Speciality speciality;

  final bool isSelected;
  final VoidCallback onTap;
  @override
  SpecialityWidgetState createState() => SpecialityWidgetState();
}

class SpecialityWidgetState extends State<SpecialityWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 110,
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  widget.onTap();
                });
              },
              child: Card(
                color: widget.isSelected
                    ? Color.fromARGB(255, 73, 181, 100)
                    : Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: Center(child: widget.speciality.icon),
              ),
            ),
          ),
          Text(
            widget.speciality.title,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
