import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:tbibi/views/appoitments/appointments_list.dart';
import 'package:tbibi/views/appoitments/patients_appointments.dart';
import 'package:tbibi/views/other/list.dart';
import 'package:tbibi/views/profile/login_page.dart';

import '../services/authentication_service.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  User? user;
  bool isDoctor = true;
  bool isAdmin = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        DocumentSnapshot snapshot =
            await _firestore.collection('users').doc(user.uid).get();

        if (snapshot.exists) {
          userData = snapshot.data() as Map<String, dynamic>;
          setState(() {
            isDoctor = userData['isDoctor'];
            isAdmin = userData['isAdmin'];
          });
        }
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  void _navigateToConfirmation() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ConfirmationListPage(),
      ),
    );
  }

  bool get doctorLoggedIn =>
      FirebaseAuth.instance.currentUser != null && isDoctor;
  bool get patientLoggedIn => FirebaseAuth.instance.currentUser != null;
  bool get adminLoggedIn =>
      FirebaseAuth.instance.currentUser != null && isAdmin;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          if (!AuthenticationService().userStatus())
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF4163CD),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage(userData['image'] ??
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/2048px-No_image_available.svg.png'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    userData['username'] ?? 'Not Connected',
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ],
              ),
            ),
          ListTile(
            title: const Row(children: [
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
            title: const Row(children: [
              Icon(
                Icons.health_and_safety,
                color: Colors.black,
              ),
              Text(' Doctors',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 19))
            ]),
            onTap: () {
              // AuthenticationService().sendMail();
              _navigateToDoctorsPage();
            },
          ),
          ListTile(
            title: const Row(children: [
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
          if (adminLoggedIn)
            ListTile(
              title: const Row(children: [
                Icon(
                  Icons.check,
                  color: Colors.black,
                ),
                Text(' Confirmation',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 19))
              ]),
              onTap: () {
                _navigateToConfirmation();
              },
            ),
          if (doctorLoggedIn)
            ListTile(
              title: const Row(children: [
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
              title: const Row(children: [
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
                    const Divider(
                      indent: 20,
                      endIndent: 20,
                      height: 5,
                    ),
                    ListTile(
                      title: const Row(
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
                    const Divider(
                      indent: 20,
                      endIndent: 20,
                      height: 5,
                    ),
                    ListTile(
                      title: const Row(
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
    Navigator.of(context).pushReplacementNamed('/post');
  }

  void _navigateToDoctorsPage() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  void _navigateToSettingsPage() {
    Navigator.of(context).pushReplacementNamed('/setting');
  }
}
