import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tbibi/services/authentication_service.dart';
import 'package:tbibi/views/detail_screen.dart';
import 'package:tbibi/views/doctor_data_page.dart';
import 'package:tbibi/views/gender_page.dart';
import 'package:tbibi/views/login_page.dart';
import 'package:tbibi/views/blog_page.dart';
import 'package:tbibi/views/profile_page.dart';
import 'package:tbibi/views/reset_password_page.dart';
import 'package:tbibi/views/specialities_page.dart';
import 'package:tbibi/views/splash_screen.dart';
import 'package:tbibi/widgets/tab_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Doctourna());
}

class Doctourna extends StatefulWidget {
  const Doctourna({super.key});

  @override
  _DoctournaState createState() => _DoctournaState();
}

class _DoctournaState extends State<Doctourna> {
  @override
  void initState() {
    AuthenticationService().checkUserStatus();
    super.initState();
  }

  bool _isDarkMode = false;

  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  final ThemeData _lightTheme =
      ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light);

  final ThemeData _darkTheme =
      ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark);

  @override
  Widget build(BuildContext context) {
    final themeData = _isDarkMode ? _darkTheme : _lightTheme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) =>
            MyTabBar(toggleTheme: toggleTheme, isDarkMode: _isDarkMode),
        '/login': (context) => LoginPage(),
        '/posts': (context) =>
            PostScreen(toggleTheme: toggleTheme, isDarkMode: _isDarkMode),
        '/post-detail': (context) =>
            PostDetail(toggleTheme: toggleTheme, isDarkMode: _isDarkMode),
<<<<<<< Updated upstream
        '/appoinment-page': (context) => AppointmentBookingPage(
            toggleTheme: toggleTheme, isDarkMode: _isDarkMode),
        '/reset_password': (context) => ResetPasswordPage(),
        '/select_gender': (context) => GenderPage(),
        '/select_speciality': (context) => SpecialitiesPage(),
        '/fill_doctor_data': (context) => DoctorDataPage(),

        // '/profile-page': (context) =>
        //     ProfilePage(toggleTheme: toggleTheme, isDarkMode: _isDarkMode),
=======
        '/reset_password': (context) => ResetPasswordPage(),
        '/profile-page': (context) =>
            ProfilePage(toggleTheme: toggleTheme, isDarkMode: _isDarkMode),
>>>>>>> Stashed changes
      },
    );
  }
}
