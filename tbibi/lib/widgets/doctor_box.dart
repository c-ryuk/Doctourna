import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tbibi/views/profile/profile_page_normal.dart';

class DoctorBox extends StatelessWidget {
  final Map<String, dynamic> doctor;
  final Function toggleTheme;
  final bool isDarkMode;

  DoctorBox({
    required this.doctor,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        String uid = doctor['uid'];

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePageNormal(
              userId: uid,
              toggleTheme: toggleTheme,
              isDarkMode: isDarkMode,
              context: context,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 70,
              backgroundImage: doctor['image'] != null
                  ? NetworkImage(doctor['image']) as ImageProvider
                  : AssetImage('assets/Doc_icon.jpg'),
            ),
            SizedBox(height: 8),
            Text(
              doctor['username'],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              doctor['speciality'] ?? 'N/A',
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
                  doctor['averageRating']?.toStringAsFixed(2) ?? '0.00',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
