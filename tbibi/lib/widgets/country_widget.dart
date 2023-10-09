import 'package:flutter/material.dart';
import '../models/country.dart';

class CountryWidget extends StatefulWidget {
  CountryWidget(
      {required this.country, required this.isSelected, required this.onTap});
  final Country country;
  final bool isSelected;
  final VoidCallback onTap;

  Color color = Colors.transparent;

  @override
  CountryWidgetState createState() => CountryWidgetState();
}

class CountryWidgetState extends State<CountryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 100,
      decoration: BoxDecoration(
          color: widget.isSelected ? Color(0xFF4163CD) : Colors.transparent,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          GestureDetector(
              onTap: () {
                setState(() {
                  widget.onTap();
                });
              },
              child: widget.country.flag),
          Text(
            widget.country.title,
            style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
          )
        ],
      ),
    );
  }
}
