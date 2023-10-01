import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tbibi/static_data/specialities_list.dart';
import 'package:tbibi/views/doctor_data_page.dart';
import 'package:tbibi/widgets/speciality_widget.dart';

class SpecialitiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DoctorDataPage();
              }));
            },
            child: Text(
              "Next",
              style: TextStyle(fontFamily: 'Poppins', fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent, elevation: 0),
          )
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: FaIcon(
                FontAwesomeIcons.userDoctor,
                size: 27,
                color: Color(0xFF4163CD),
              ),
            ),
            Text(
              " Specialities",
              style: TextStyle(
                  fontFamily: 'Poppins Medium',
                  fontSize: 25,
                  color: Color(0xFF4163CD)),
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
                children: specialities
                    .map((e) => SpecialityWidget(speciality: e))
                    .toList())
          ],
        ),
      ),
    );
  }
}
