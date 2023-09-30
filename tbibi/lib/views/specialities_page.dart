import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tbibi/models/speciality.dart';
import 'package:tbibi/widgets/speciality_widget.dart';

class SpecialitiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: FaIcon(
                FontAwesomeIcons.userDoctor,
                size: 27,
              ),
            ),
            Text(
              " Specialities",
              style: TextStyle(fontFamily: 'Poppins Medium', fontSize: 25),
            )
          ],
        ),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Select your speciality",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Wrap(
              direction: Axis.horizontal,
              children: [
                SpecialityWidget(
                  speciality: Speciality(
                    title: "Dentist",
                    icon: Icon(
                      Icons.mobile_friendly_outlined,
                      size: 38,
                    ),
                  ),
                ),
                SpecialityWidget(
                  speciality: Speciality(
                    title: "Player",
                    icon: Icon(
                      Icons.play_circle,
                      size: 38,
                    ),
                  ),
                ),
                SpecialityWidget(
                  speciality: Speciality(
                    title: "Dentist",
                    icon: Icon(
                      Icons.mobile_friendly_outlined,
                      size: 38,
                    ),
                  ),
                ),
                SpecialityWidget(
                  speciality: Speciality(
                    title: "Dentist",
                    icon: Icon(
                      Icons.mobile_friendly_outlined,
                      size: 38,
                    ),
                  ),
                ),
                SpecialityWidget(
                  speciality: Speciality(
                    title: "Dentist",
                    icon: Icon(
                      Icons.mobile_friendly_outlined,
                      size: 38,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
