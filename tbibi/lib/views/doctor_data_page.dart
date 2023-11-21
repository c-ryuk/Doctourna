import 'package:flutter/material.dart';
import 'package:tbibi/models/country.dart';
import 'package:tbibi/services/collect_doctor_data.dart';
import 'package:tbibi/static_data/countries_list.dart';
import 'package:tbibi/views/confirmation.dart';

import 'package:tbibi/widgets/country_widget.dart';
import 'package:tbibi/widgets/location_builder.dart';
import 'package:tbibi/widgets/signbutton.dart';

import '../widgets/governorats_dropdown.dart';

class DoctorDataPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DoctorFormPage();
  }
}

class DoctorFormPage extends State<DoctorDataPage> {
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobilePhone = TextEditingController();
  bool checkBoxValue = false;
  int selectedIndex = -1;
  bool isSelected = false;
  String selectedCountry = "";
  bool isTapedLocation = false;
  bool isLocated = false;

  @override
  void initState() {
    super.initState();
  }

  void handleCountryTap(int index, Country value) {
    setState(() {
      selectedIndex = index;
      selectedCountry = value.title;
      isSelected = true;
      print(value.title);
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF4163CD), size: 30),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          " Validation",
          style: TextStyle(
              fontFamily: 'Poppins Medium',
              fontSize: 27,
              color: Color(0xFF4163CD)),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Where are you from ?",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 22,
                ),
              ),
              const SizedBox(
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
                            handleCountryTap(entries.key, entries.value);
                          },
                          isSelected: entries.key == selectedIndex,
                          country: entries.value))
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          isTapedLocation
                              ? LocationBuilder()
                              : GovernoratsDropdown(),
                          SizedBox(width: 5),
                          Expanded(
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xFF4163CD),
                                      borderRadius: BorderRadius.circular(10)),
                                  height: 60,
                                  width: 60,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isTapedLocation = !isTapedLocation;
                                      });
                                    },
                                    child: Icon(
                                      isTapedLocation
                                          ? Icons.location_disabled_rounded
                                          : Icons.location_searching_rounded,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  )))
                        ],
                      ),
                      const Divider(),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name should not be empty.';
                          }
                          return null;
                        },
                        controller: fullName,
                        decoration: InputDecoration(
                          hintText: "Full Name",
                          hintStyle:
                              TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        validator: (value) {
                          String pattern =
                              r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
                          RegExp regExp = RegExp(pattern);
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email address.';
                          }

                          if (!regExp.hasMatch(value)) {
                            return 'Invalid email address';
                          }

                          return null;
                        },
                        controller: email,
                        decoration: const InputDecoration(
                          hintText: "Email",
                          hintStyle:
                              TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your mobile number';
                          }

                          RegExp tunisianMobileNumberRegExp =
                              RegExp(r'^[2-9]\d{7}$');
                          if (!tunisianMobileNumberRegExp.hasMatch(value)) {
                            return 'Invalid Tunisian mobile number';
                          }

                          return null;
                        },
                        controller: mobilePhone,
                        decoration: const InputDecoration(
                          hintText: "+216",
                          hintStyle:
                              TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.phone),
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
                        title: const Text(
                          "I agree to all terms and conditions of use",
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
                        ),
                      ),
                      if (!checkBoxValue)
                        Text(
                          'Please agree to the terms and conditions.',
                          style: TextStyle(color: Colors.red),
                        ),
                      const SizedBox(
                        height: 30,
                      ),
                      SignButton(
                          text: "Submit",
                          textColor: Colors.white,
                          backgroundColor: Color(0xFF4163CD),
                          function: () async {
                            if (_formKey.currentState!.validate() &&
                                DocData().getLocation() != null &&
                                isSelected) {
                              DocData().setForm(
                                  country: selectedCountry,
                                  fullName: fullName.text,
                                  email: email.text,
                                  phone: mobilePhone.text);
                              DocData().getData();
                              DocData().emptyData();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ConfirmationScreen()),
                                  (route) => false);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Color(0xFF4163CD),
                                  content: Text(
                                    'Please fill your location data.',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white),
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          }),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
