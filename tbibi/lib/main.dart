import 'package:flutter/material.dart';
import 'package:tbibi/views/appoinment_page.dart';
import 'package:tbibi/views/detail_screen.dart';
import 'package:tbibi/views/login_page.dart';
import 'package:tbibi/views/blog_page.dart';
import 'package:tbibi/views/profile_page.dart';
import 'package:tbibi/views/splash_screen.dart';
import 'package:tbibi/widgets/tab_bar.dart';

void main() {
  runApp(const Doctourna());
}

class Doctourna extends StatefulWidget {
  const Doctourna({super.key});

  @override
  _DoctournaState createState() => _DoctournaState();
}

class _DoctournaState extends State<Doctourna> {
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
        '/appoinment-page': (context) => AppointmentBookingPage(
            toggleTheme: toggleTheme, isDarkMode: _isDarkMode),
        // '/profile-page': (context) =>
        //     ProfilePage(toggleTheme: toggleTheme, isDarkMode: _isDarkMode),
      },
    );
  }
}
