import 'package:flutter/material.dart';
import 'package:tbibi/models/location.dart';

class LocationWidget extends StatelessWidget {
  LocationWidget({required this.location});
  final LocationModel location;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 5,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF4163CD),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          height: 60,
          child: Text(
            "${location.governorat}, ${location.locality}",
            style: TextStyle(
                fontFamily: "Poppins", fontSize: 20, color: Colors.white),
          ),
        ));
  }
}
