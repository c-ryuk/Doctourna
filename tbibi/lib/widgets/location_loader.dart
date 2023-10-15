import 'package:flutter/material.dart';

class LocationLoader extends StatelessWidget {
  const LocationLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 5,
        child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF4163CD),
              borderRadius: BorderRadius.circular(12),
            ),
            height: 60,
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              color: Colors.white,
            )));
  }
}
