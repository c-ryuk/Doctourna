import 'package:flutter/material.dart';
import 'package:tbibi/models/speciality.dart';

import 'package:tbibi/static_data/specialities_list.dart';
import 'package:tbibi/views/doctor_data_page.dart';
import 'package:tbibi/widgets/speciality_widget.dart';

class SpecialitiesPage extends StatefulWidget {
  @override
  SpecialitiesPageState createState() => SpecialitiesPageState();
}

class SpecialitiesPageState extends State<SpecialitiesPage> {
  int selectedIndex = -1;
  bool isSelected = false;
  String selectedSpeciality = "";

  void handleSpecialityTap(int index, Speciality value) {
    setState(() {
      selectedIndex = index;
      selectedSpeciality = value.title;
      isSelected = true;
      print(value.title);
    });
  }

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
                if (isSelected == false) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Center(
                              child: Text(
                            "Alert !",
                            style: TextStyle(
                                fontFamily: 'Poppins Medium', fontSize: 24),
                          )),
                          content: Text(
                            "You must select your gender to continue",
                            style:
                                TextStyle(fontFamily: 'Poppins', fontSize: 16),
                          ),
                          actions: [
                            Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF4163CD)),
                                    child: Text(
                                      "Okay",
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          color: Colors.white),
                                    )))
                          ],
                        );
                      });
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DoctorDataPage();
                  }));
                }
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
                        .asMap()
                        .entries
                        .map((entries) => SpecialityWidget(
                              onTap: () {
                                handleSpecialityTap(entries.key, entries.value);
                              },
                              isSelected: entries.key == selectedIndex,
                              speciality: entries.value,
                            ))
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
