import 'package:flutter/material.dart';
import 'package:tbibi/models/doctor.dart';

class DoctorBox extends StatelessWidget {
  final Doctor doctor;

  DoctorBox({required this.doctor});

  void _navigateToProfilePage(BuildContext context) {
    Navigator.pushNamed(context, '/profile-page');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _navigateToProfilePage(context);
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Image.asset(
              doctor.imageUrl,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8),
            Text(
              doctor.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              doctor.speciality,
              style: TextStyle(),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                Text(
                  doctor.rating as String,
                  style: TextStyle(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
