import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tbibi/views/home.dart';
import 'package:tbibi/views/other/settings.dart';
import 'package:tbibi/views/posts/blog_page.dart';
import 'package:tbibi/widgets/drawer.dart';

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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      DoctorsListPage(
          toggleTheme: widget.toggleTheme, isDarkMode: widget.isDarkMode),
      PostScreen(
          toggleTheme: widget.toggleTheme, isDarkMode: widget.isDarkMode),
      Settings(toggleTheme: widget.toggleTheme, isDarkMode: widget.isDarkMode),
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Doctourna',
          style: TextStyle(
              fontFamily: 'Poppins Medium',
              color: Color(0xFF4163CD),
              fontSize: 24),
        ),
        backgroundColor: widget.isDarkMode ? Colors.black : Colors.white12,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              color: Color(0xFF4163CD),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Color(0xFF4163CD),
          statusBarColor: Color(0xFF4163CD),
        ),
      ),
      drawer: AppDrawer(),
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
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
