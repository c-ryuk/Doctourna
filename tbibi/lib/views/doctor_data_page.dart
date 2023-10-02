import 'package:flutter/material.dart';
import 'package:tbibi/static_data/countries_list.dart';
import 'package:tbibi/static_data/governorate_list.dart';
import 'package:tbibi/widgets/country_widget.dart';
import 'package:tbibi/widgets/signbutton.dart';

class DoctorDataPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DoctorFormPage();
  }
}

class DoctorFormPage extends State<DoctorDataPage> {
  bool checkBoxValue = false;
  @override
  Widget build(BuildContext context) {
    var selectedGovernante;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          " Validation",
          style: TextStyle(
              fontFamily: 'Poppins Medium',
              fontSize: 27,
              color: Color(0xFF4163CD)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Where are you from ?",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 85,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children:
                    countries.map((e) => CountryWidget(country: e)).toList(),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        hintText: "Governorate",
                        hintStyle:
                            TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                      icon: const Icon(
                        Icons.home,
                        color: Colors.black,
                      ),
                      value: selectedGovernante,
                      onChanged: (item) => setState(() {
                        selectedGovernante = item;
                      }),
                      items: governorates.map((String gouvernorat) {
                        return DropdownMenuItem<String>(
                          value: gouvernorat,
                          child: Text(
                            gouvernorat,
                            style: const TextStyle(
                                fontSize: 18, fontFamily: 'Poppins'),
                          ),
                        );
                      }).toList(),
                    ),
                    Divider(),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: "Name",
                        hintStyle:
                            TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: "ForeName",
                        hintStyle:
                            TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: "Email",
                        hintStyle:
                            TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: "Mobile Phone",
                        hintStyle:
                            TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                    ),
                    CheckboxListTile(
                      activeColor: Color(0xFF4163CD),
                      value: checkBoxValue,
                      onChanged: (val) {
                        setState(() {
                          checkBoxValue = val!;
                        });
                      },
                      title: Text(
                        "I accept all terms of use",
                        style: TextStyle(fontFamily: 'Poppins'),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SignButton(
                        text: "Submit",
                        textColor: Colors.white,
                        backgroundColor: Color(0xFF4163CD),
                        function: () {}),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
