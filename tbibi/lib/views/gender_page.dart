import 'package:flutter/material.dart';
import 'package:tbibi/widgets/gender.dart';

import '../models/gender.dart';

class GenderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          ElevatedButton(
            onPressed: () {},
            child: Text(
              "Skip",
              style: TextStyle(fontFamily: 'Poppins', fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent, elevation: 0),
          )
        ],
      ),
      body: Container(
        child: Column(children: [
          Expanded(
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
                    GenderWidget(
                      gender: Gender(icon: Icon(Icons.male), title: "Male"),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GenderWidget(
                        gender:
                            Gender(icon: Icon(Icons.female), title: "Female"))
                  ],
                ),
              )),
        ]),
      ),
    );
  }
}
