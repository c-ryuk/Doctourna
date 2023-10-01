import 'package:flutter/material.dart';
import '../models/country.dart';

class CountryWidget extends StatelessWidget {
  CountryWidget({required this.country});
  final Country country;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 110,
      color: Colors.transparent,
      child: Column(
        children: [
          country.flag,
          Text(
            country.title,
            style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
          )
        ],
      ),
    );
  }
}
