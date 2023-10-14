import 'package:flutter/material.dart';
import 'package:tbibi/models/doctor.dart';
import 'package:tbibi/models/user.dart';
import 'package:tbibi/views/profile_page.dart';

class DoctorBox extends StatelessWidget {
  final User doctor;
  final Function toggleTheme;
  final bool isDarkMode;

  DoctorBox(
      {required this.doctor,
      required this.toggleTheme,
      required this.isDarkMode});

  void _navigateToProfilePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(
            doctor: doctor, toggleTheme: toggleTheme, isDarkMode: isDarkMode),
      ),
    );
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
              height: 150,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8),
            Text(
              doctor.fullName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              doctor.specialty,
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
                  doctor.rating.toString(),
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
