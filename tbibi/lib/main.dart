// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, sort_child_properties_last, library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:tbibi/pages/Screen1.dart';
import 'package:tbibi/pages/Screen2.dart';
import 'package:tbibi/pages/Screen3.dart';
import 'pages/ProfilePage.dart';

void main() {
  runApp(MyApp());
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

  @override
  Widget build(BuildContext context) {
    final themeData = _isDarkMode ? _darkTheme : _lightTheme;

    return MaterialApp(
      theme: themeData,
      home: MyTabBar(
        toggleTheme: toggleTheme,
        isDarkMode: _isDarkMode,
      ),
    );
  }
}

class MyTabBar extends StatefulWidget {
  final Function toggleTheme;
  final bool isDarkMode;

  const MyTabBar(
      {Key? key, required this.toggleTheme, required this.isDarkMode})
      : super(key: key);

  @override
  _MyTabBarState createState() => _MyTabBarState();
}

ThemeData _lightTheme =
    ThemeData(primarySwatch: Colors.lightGreen, brightness: Brightness.light);

ThemeData _darkTheme =
    ThemeData(primarySwatch: Colors.lightGreen, brightness: Brightness.dark);

class _MyTabBarState extends State<MyTabBar> {
  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  bool _isSidebarOpen = false;

  final List<Widget> _screens = [
    Screen1(),
    Screen2(),
    Screen3(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _toggleSidebar() {
    setState(() {
      _isSidebarOpen = !_isSidebarOpen;
    });
  }

  void _navigateToProfilePage() {
    // Navigate to the ProfilePage when the user icon is pressed
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProfilePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doctourna',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: _navigateToProfilePage, // Navigate to ProfilePage
          ),
          IconButton(
            onPressed: () {
              widget.toggleTheme(); // Toggle the theme
              print("Theme changed: ${widget.isDarkMode}");
            },
            icon: Icon(widget.isDarkMode ? Icons.dark_mode : Icons.light_mode),
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: _toggleSidebar, // Toggle SideBar
        ),
      ),
      body: GestureDetector(
        onTap: () {
          if (_isSidebarOpen) {
            _toggleSidebar();
          }
        },
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              children: _screens,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            // Side Bar content
            if (_isSidebarOpen)
              Container(
                color: Colors.black.withOpacity(0.5),
              ),
            if (_isSidebarOpen)
              Container(
                width: 200,
                child: Drawer(
                  child: ListView(
                    children: [
                      DrawerHeader(
                        child: Text('Sidebar Header'),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                        ),
                      ),
                      ListTile(
                        title: Text('Item 1'),
                        onTap: () {
                          // Handle sidebar item 1 tap
                        },
                      ),
                      ListTile(
                        title: Text('Item 2'),
                        onTap: () {
                          // Handle sidebar item 2 tap
                        },
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Screen 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Screen 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Screen 3',
          ),
        ],
      ),
    );
  }
}
