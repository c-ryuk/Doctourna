// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:tbibi/views/appoinment_page.dart';
import 'package:tbibi/views/detail_screen.dart';
import 'package:tbibi/views/doctor_data_page.dart';
import 'package:tbibi/views/login_page.dart';
import 'package:tbibi/views/blog_page.dart';
import 'package:tbibi/views/profile_page.dart';
import 'package:tbibi/widgets/tab_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  final ThemeData _lightTheme =
      ThemeData(primarySwatch: Colors.lightGreen, brightness: Brightness.light);

  final ThemeData _darkTheme =
      ThemeData(primarySwatch: Colors.lightGreen, brightness: Brightness.dark);

  @override
  Widget build(BuildContext context) {
    final themeData = _isDarkMode ? _darkTheme : _lightTheme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      initialRoute: '/',
      routes: {
        '/': (context) =>
            MyTabBar(toggleTheme: toggleTheme, isDarkMode: _isDarkMode),
        '/login': (context) => LoginPage(),
        '/posts': (context) =>
            PostScreen(toggleTheme: toggleTheme, isDarkMode: _isDarkMode),
        '/post-detail': (context) =>
            PostDetail(toggleTheme: toggleTheme, isDarkMode: _isDarkMode),
        '/appoinment-page': (context) => AppointmentBookingPage(
            toggleTheme: toggleTheme, isDarkMode: _isDarkMode),
        '/profile-page': (context) =>
            ProfilePage(toggleTheme: toggleTheme, isDarkMode: _isDarkMode),
      },
    );
  }
}
