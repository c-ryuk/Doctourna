import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_email_sender/flutter_email_sender.dart';
=======
import 'package:tbibi/views/appointments_list.dart';
import 'package:tbibi/views/patients_appointments.dart';
>>>>>>> a08152e06062e944d844d6894fddd0d39c2bf660

import '../services/authentication_service.dart';
import '../views/login_page.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  bool isDoctor = true;

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
    _loadIsCompanyAttribute();
  }

  Future<void> _loadIsCompanyAttribute() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        setState(() {
          isDoctor = userSnapshot.get('isDoctor');
        });
      } catch (e) {
        print('Error loading isDoctor attribute: $e');
      }
    }
  }

  bool get doctorLoggedIn =>
      FirebaseAuth.instance.currentUser != null && isDoctor;
  bool get patientLoggedIn => FirebaseAuth.instance.currentUser != null;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          if (!AuthenticationService().userStatus())
            DrawerHeader(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage(user?.photoURL ??
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/2048px-No_image_available.svg.png'),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    user?.displayName ?? 'Not Connected',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                  Text("${user?.email}",
                      style: TextStyle(fontFamily: 'Poppins')),
                ],
              ),
              decoration: BoxDecoration(
                color: Color(0xFF4163CD),
              ),
            ),
          ListTile(
            title: Row(children: [
              Icon(
                Icons.home,
                color: Colors.black,
              ),
              Text(' Home',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 19))
            ]),
            onTap: () {
              _navigateToDoctorsPage();
            },
          ),
          ListTile(
            title: Row(children: [
              Icon(
                Icons.health_and_safety,
                color: Colors.black,
              ),
              Text(' Doctors',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 19))
            ]),
            onTap: () {
              AuthenticationService().sendMail();
              _navigateToDoctorsPage();
            },
          ),
          ListTile(
            title: Row(children: [
              Icon(
                Icons.article,
                color: Colors.black,
              ),
              Text(' Blogger',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 19))
            ]),
            onTap: () {
              _navigateToPostsPage();
            },
          ),
          ListTile(
            title: Row(children: [
              Icon(
                Icons.settings,
                color: Colors.black,
              ),
              Text(' Settings',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 19))
            ]),
            onTap: () {
              _navigateToSettingsPage();
            },
          ),
          if (doctorLoggedIn)
            ListTile(
              title: Row(children: [
                Icon(
                  Icons.list_alt,
                  color: Colors.black,
                ),
                Text('Appointments',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 19))
              ]),
              onTap: () {
                _navigateToAppointmentsPage();
              },
            ),
          if (patientLoggedIn)
            ListTile(
              title: Row(children: [
                Icon(
                  Icons.format_list_bulleted,
                  color: Colors.black,
                ),
                Text('My Appointments',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 19))
              ]),
              onTap: () {
                _navigateToPatientAppointmentsPage();
              },
            ),
          AuthenticationService().userStatus()
              ? Padding(
                  padding: const EdgeInsets.only(top: 500),
                  child: Column(children: [
                    Divider(
                      indent: 20,
                      endIndent: 20,
                      height: 5,
                    ),
                    ListTile(
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.login,
                              color: Color(0xFF4163CD),
                            ),
                            Text(' Login',
                                style: TextStyle(
                                    color: Color(0xFF4163CD),
                                    fontFamily: 'Poppins',
                                    fontSize: 19))
                          ]),
                      onTap: () {
                        setState(() {
                          _navigateToLoginPage();
                        });
                      },
                    ),
                  ]),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 330),
                  child: Column(children: [
                    Divider(
                      indent: 20,
                      endIndent: 20,
                      height: 5,
                    ),
                    ListTile(
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.redAccent,
                            ),
                            Text(' Logout',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.redAccent,
                                    fontSize: 19))
                          ]),
                      onTap: () {
                        AuthenticationService().logout();
                        Navigator.of(context).pop();
                        setState(() {});
                      },
                    ),
                  ]),
                ),
        ],
      ),
    );
  }

  void _navigateToLoginPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  void _navigateToAppointmentsPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AppointmentList(),
      ),
    );
  }

  void _navigateToPatientAppointmentsPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AppointmentListPatients(),
      ),
    );
  }

  void _navigateToPostsPage() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  void _navigateToDoctorsPage() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  void _navigateToSettingsPage() {
    Navigator.of(context).pushReplacementNamed('/home');
  }
}
