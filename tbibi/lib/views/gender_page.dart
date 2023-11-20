import 'package:flutter/material.dart';
import 'package:tbibi/services/collect_doctor_data.dart';
import 'package:tbibi/widgets/gender_widget.dart';
import '../models/gender.dart';

class GenderPage extends StatefulWidget {
  @override
  GenderPageState createState() => GenderPageState();
}

class GenderPageState extends State<GenderPage> {
  bool isMaleVisible = true;
  bool isFemaleVisible = true;

  @override
  void initState() {
    super.initState();
  }

  String gender() {
    if (!isFemaleVisible && isMaleVisible)
      return "Male";
    else
      return 'Female';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF4163CD), size: 30),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Visibility(
            visible: !(isFemaleVisible == true && isMaleVisible == true),
            child: ElevatedButton(
              onPressed: () async {
                print(gender());
                DocData().setGender(gender: gender());
                Navigator.pushNamed(context, '/select_speciality');
              },
              child: Text(
                "Next",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    color: Color(0xFF4163CD)),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent, elevation: 0),
            ),
          )
        ],
      ),
      body: Container(
        child: Column(children: [
          const Expanded(
              flex: 1,
              child: Column(
                children: [
                  SizedBox(height: 70),
                  Text(
                    "Select your gender",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 29,
                        fontWeight: FontWeight.bold),
                  ),
                  Text("Let us know you better",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          color: Colors.grey))
                ],
              )),
          Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  children: [
                    Container(
                      height: 120,
                      child: Visibility(
                        visible: isMaleVisible,
                        child: GenderWidget(
                          toHide: () async {
                            setState(() {
                              isFemaleVisible = !isFemaleVisible;
                            });
                          },
                          gender: Gender(
                              icon: Icon(
                                Icons.male,
                                size: 40,
                              ),
                              title: "Male"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 120,
                      child: Visibility(
                        visible: isFemaleVisible,
                        child: GenderWidget(
                          toHide: () async {
                            setState(() {
                              isMaleVisible = !isMaleVisible;
                            });
                          },
                          gender: Gender(
                              icon: Icon(
                                Icons.female,
                                size: 40,
                              ),
                              title: "Female"),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ]),
      ),
    );
  }
}
