import 'package:shared_preferences/shared_preferences.dart';

class DocData {
  DocData();
  Future setGender({required gender}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('gender', gender);
  }

  Future setSpeciality({required speciality}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('speciality', speciality);
  }

  Future setLocation({required gouvernorat}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('location', gouvernorat);
  }

  Future setForm(
      {required country,
      required fullName,
      required email,
      required phone}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('country', country);
    prefs.setString('fullName', fullName);
    prefs.setString('email', email);
    prefs.setString('phone', phone);
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? gender = prefs.getString('gender');
    final String? speciality = prefs.getString('speciality');
    final String? country = prefs.getString('country');
    final String? fullName = prefs.getString('fullName');
    final String? email = prefs.getString('email');
    final String? mobilePhone = prefs.getString('phone');
    final String? location = prefs.getString('location');

    Map<String, String?> doctorData = {
      'Gender': gender,
      'Speciality': speciality,
      'Country': country,
      'Location': location,
      'FullName': fullName,
      'Email': email,
      'MobilePhone': mobilePhone
    };
    print(doctorData);

    return doctorData;
  }

  emptyData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('gender');
    await prefs.remove('speciality');
    await prefs.remove('country');
    await prefs.remove('fullName');
    await prefs.remove('email');
    await prefs.remove('phone');
    await prefs.remove('location');
  }
}
