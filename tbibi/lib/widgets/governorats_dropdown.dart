import 'package:flutter/material.dart';
import 'package:tbibi/services/get_doctor_data.dart';

import '../static_data/governorate_list.dart';

class GovernoratsDropdown extends StatefulWidget {
  @override
  State<GovernoratsDropdown> createState() => _GovernoratsDropdownState();
}

class _GovernoratsDropdownState extends State<GovernoratsDropdown> {
  var selectedGovernante;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Container(
        height: 60,
        child: DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            hintText: "Governorate",
            hintStyle: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          ),
          icon: const Icon(
            Icons.home,
          ),
          value: selectedGovernante,
          onChanged: (item) => setState(() {
            selectedGovernante = item;
            DocData().setLocation(gouvernorat: selectedGovernante);
          }),
          items: governorates.map((String gouvernorat) {
            return DropdownMenuItem<String>(
              value: gouvernorat,
              child: Text(
                gouvernorat,
                style: const TextStyle(fontSize: 18, fontFamily: 'Poppins'),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
