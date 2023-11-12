import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tbibi/services/authentication_service.dart';
import 'package:tbibi/views/blog_page.dart';
import 'package:tbibi/views/home.dart';
import 'package:tbibi/views/login_page.dart';
import 'package:tbibi/views/settings.dart';

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

  void _navigateToLoginPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
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
              color: Color(0xFF4163CD), // Replace with your custom icon
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
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage('assets/hamza.png'),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "Hamza REKIK",
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Status : Verified",
                          style: TextStyle(fontFamily: 'Poppins')),
                      Icon(Icons.verified)
                    ],
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Color(0xFF4163CD),
              ),
            ),
            AuthenticationService().userStatus()
                ? ListTile(
                    title: Row(children: [
                      Icon(
                        Icons.login,
                        color: Colors.black,
                      ),
                      Text(' Login',
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 19))
                    ]),
                    onTap: () {
                      _navigateToLoginPage();
                    },
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 550),
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
                          // Close the drawer
                          setState(() {
                            AuthenticationService().logout();
                            Navigator.of(context).pop();
                          });
                        },
                      ),
                    ]),
                  ),
          ],
        ),
      ),
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
