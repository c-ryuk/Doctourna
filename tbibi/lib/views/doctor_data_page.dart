import 'package:flutter/material.dart';
import 'package:tbibi/models/country.dart';
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
  int selectedIndex = -1;
  bool isSelected = false;
  String selectedCountry = "";

  void handleSpecialityTap(int index, Country value) {
    setState(() {
      selectedIndex = index;
      selectedCountry = value.title;
      isSelected = true;
      print(value.title);
    });
  }

  @override
  Widget build(BuildContext context) {
    var selectedGovernante;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.red, size: 30),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          " Validation",
          style: TextStyle(
              fontFamily: 'Poppins Medium', fontSize: 27, color: Colors.red),
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
                children: countries
                    .asMap()
                    .entries
                    .map((entries) => CountryWidget(
                        onTap: () {
                          handleSpecialityTap(entries.key, entries.value);
                        },
                        isSelected: entries.key == selectedIndex,
                        country: entries.value))
                    .toList(),
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
                        hintText: "Full Name",
                        hintStyle:
                            TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
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
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
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
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                      ),
                    ),
                    CheckboxListTile(
                      activeColor: Colors.red,
                      value: checkBoxValue,
                      onChanged: (val) {
                        setState(() {
                          checkBoxValue = val!;
                        });
                      },
                      title: Text(
                        "I agree to all terms and conditions of use",
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SignButton(
                        text: "Submit",
                        textColor: Colors.white,
                        backgroundColor: Colors.red,
                        function: () {}),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
