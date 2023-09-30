import 'package:flutter/material.dart';
import 'package:tbibi/models/speciality.dart';

class SpecialityWidget extends StatelessWidget {
  SpecialityWidget({required this.speciality});
  final Speciality speciality;
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
            child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: speciality.icon),
          ),
          Text(
            speciality.title,
            style: TextStyle(fontFamily: 'Poppins', fontSize: 18),
          )
        ],
      ),
    );
  }
}
