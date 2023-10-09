// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, sized_box_for_whitespace, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tbibi/views/blog_page.dart';
import 'package:tbibi/views/home.dart';
import 'package:tbibi/views/login_page.dart';
import 'package:tbibi/views/settings.dart';

import '../views/profile_page.dart';

class MyTabBar extends StatefulWidget {
  final Function toggleTheme;
  final bool isDarkMode;

  const MyTabBar(
      {Key? key, required this.toggleTheme, required this.isDarkMode})
      : super(key: key);

  @override
  _MyTabBarState createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> {
  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  bool _isSidebarOpen = false;

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
        builder: (context) => ProfilePage(
            toggleTheme: widget.toggleTheme, isDarkMode: widget.isDarkMode),
      ),
    );
  }

  void _navigateToLoginPage() {
    // Navigate to the LoginPage
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      DoctorsListPage(),
      PostScreen(
          toggleTheme: widget.toggleTheme, isDarkMode: widget.isDarkMode),
      Settings(toggleTheme: widget.toggleTheme, isDarkMode: widget.isDarkMode),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.isDarkMode ? Colors.black : Colors.white12,
        elevation: 0,
        leading: IconButton(
          iconSize: 30,
          icon: Icon(Icons.menu),
          color: Color(0xFF4163CD),
          onPressed: _toggleSidebar,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Color(0xFF4163CD),
          statusBarColor: Color(0xFF4163CD),
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
                      ListTile(
                        title: Text('Login'),
                        onTap: () {
                          _navigateToLoginPage();
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
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Posts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
