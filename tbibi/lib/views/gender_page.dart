import 'package:flutter/material.dart';
import 'package:tbibi/views/specialities_page.dart';
import 'package:tbibi/widgets/gender_widget.dart';
import '../models/gender.dart';

class GenderPage extends StatefulWidget {
  @override
  GenderPageState createState() => GenderPageState();
}

@override
void initState() {}

class GenderPageState extends State<GenderPage> {
  bool isMaleVisible = true;
  bool isFemaleVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.red, size: 30),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          ElevatedButton(
            onPressed: () {
              if (isFemaleVisible == true && isMaleVisible == true) {
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
                          "Please select your gender to continue",
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                        ),
                        actions: [
                          Center(
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red),
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
                  return SpecialitiesPage();
                }));
              }
            },
            child: Text(
              "Next",
              style: TextStyle(
                  fontFamily: 'Poppins', fontSize: 18, color: Colors.red),
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent, elevation: 0),
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
                          toHide: () {
                            setState(() {
                              isFemaleVisible = !isFemaleVisible;
                              print("fmale $isFemaleVisible");
                              print("male $isMaleVisible");
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
                          toHide: () {
                            setState(() {
                              isMaleVisible = !isMaleVisible;
                              print("fmale $isFemaleVisible");
                              print("male $isMaleVisible");
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
