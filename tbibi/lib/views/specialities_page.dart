import 'package:flutter/material.dart';

import 'package:tbibi/static_data/specialities_list.dart';
import 'package:tbibi/views/doctor_data_page.dart';
import 'package:tbibi/widgets/speciality_widget.dart';

class SpecialitiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
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
          title: Text(
            " Specialities",
            style: TextStyle(
                fontFamily: 'Poppins Medium',
                fontSize: 25,
                color: Color(0xFF4163CD)),
          )),
      body: Container(
        alignment: Alignment.center,
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
            Expanded(
              child: ListView(children: [
                Wrap(
                    direction: Axis.horizontal,
                    children: spec
                        .map((e) => SpecialityWidget(speciality: e))
                        .toList(),
                    alignment: WrapAlignment.center),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
