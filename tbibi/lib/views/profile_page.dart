// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:tbibi/views/appoinment_page.dart';
import 'package:tbibi/views/edit_profile_page.dart';
import 'package:tbibi/widgets/button.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  final Function toggleTheme;
  final bool isDarkMode;
  const ProfilePage(
      {super.key, required this.toggleTheme, required this.isDarkMode});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          buildTop(),
          buildContent(),
        ]),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(15),
        height: 130,
        decoration: BoxDecoration(
          color:
              widget.isDarkMode ? Colors.black.withOpacity(0.3) : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Consultation price",
                  style: TextStyle(
                    fontSize: 20,
                    color: widget.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  "\$30",
                  style: TextStyle(
                    color: widget.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            InkWell(
              onTap: () {
                _navigateToAppoinmentPage();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: Color(0xFF4163CD).withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Book Appointment",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContent() => Column(
        children: [
          SizedBox(height: 8),
          Text(
            'Hamed TRIKI',
            style: TextStyle(fontSize: 28),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.healing_outlined,
                color: widget.isDarkMode
                    ? Color(0xFF4163CD).withOpacity(0.8)
                    : Color(0xFF4163CD).withOpacity(0.8),
                size: 25,
              ),
              SizedBox(width: 8),
              Text(
                'something',
                style: TextStyle(
                    fontSize: 20,
                    color: widget.isDarkMode ? Colors.white : Colors.black),
              ),
            ],
          ),
          SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSocialIcon(FontAwesome.phone, () {
                _launchPhoneCall('22 555 888');
              }),
              SizedBox(width: 12),
              buildSocialIcon(FontAwesome.facebook),
              SizedBox(width: 12),
              buildSocialIcon(FontAwesome.location_arrow),
            ],
          ),
          SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildCountWidget("Patients", "1230"),
              buildCountWidget("Experience", "15y"),
              buildCountWidget("Rating", "4.4"),
            ],
          ),
          SizedBox(height: 36),
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About Me',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Relieves pain and reduces inflammation, providing fast relief from headaches and muscle aches.',
                  style: TextStyle(
                      fontSize: 16,
                      color: widget.isDarkMode ? Colors.white : Colors.black),
                ),
              ],
            ),
          ),
          SizedBox(width: 36),
          SizedBox(
            height: 36,
          ),
        ],
      );

  Widget buildTop() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 140 / 2),
          child: buildCoverImage(),
        ),
        Positioned(
          top: 210 - 194 / 2,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              buildProfilImage(),
              Positioned(
                bottom: 0,
                left: 0,
                child: InkWell(
                  onTap: () {
                    _navigateToEditProfilePage();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.isDarkMode
                          ? Color(0xFF4163CD)
                          : Color(0xFF4163CD),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 20,
          left: 0,
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: 40,
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }

  Widget buildCoverImage() => Container(
        color: widget.isDarkMode
            ? Color(0xFF4163CD).withOpacity(0.8)
            : Color(0xFF4163CD).withOpacity(0.8),
        child: Image.network(
          'https://res.cloudinary.com/dhzlfojtv/image/upload/v1696246033/istockphoto-831557666-612x612-removebg-preview_zs3zjc.png',
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        ),
      );

  Widget buildProfilImage() => CircleAvatar(
        radius: 144 / 2,
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(
          'https://img.a.transfermarkt.technology/portrait/big/28003-1694590254.jpg?lm=1',
        ),
      );
  Widget buildSocialIcon(IconData icon, [VoidCallback? onTapFunction]) =>
      CircleAvatar(
          radius: 25,
          child: Material(
            shape: CircleBorder(),
            clipBehavior: Clip.hardEdge,
            color: widget.isDarkMode
                ? Color(0xFF4163CD).withOpacity(0.8)
                : Color(0xFF4163CD).withOpacity(0.8),
            child: Tooltip(
              message: getTooltipMessage(icon),
              child: InkWell(
                onTap: icon == FontAwesome.location_arrow
                    ? _showAddressDialog
                    : onTapFunction ?? () {},
                child: Center(
                    child: Icon(
                  icon,
                  size: 32,
                  color: widget.isDarkMode ? Colors.white : Colors.black,
                )),
              ),
            ),
          ));

  String getTooltipMessage(IconData icon) {
    if (icon == FontAwesome.phone) {
      return 'Phone';
    } else if (icon == FontAwesome.facebook) {
      return 'Facebook';
    } else if (icon == FontAwesome.location_arrow) {
      return 'Location';
    } else {
      return '';
    }
  }

  Widget buildCountWidget(String label, String count) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            count,
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
                fontSize: 16,
                color: widget.isDarkMode ? Colors.black : Colors.grey),
          ),
        ],
      ),
    );
  }

  void _navigateToEditProfilePage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const EditProfilePage(),
      ),
    );
  }

  void _navigateToAppoinmentPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AppointmentBookingPage(
            toggleTheme: widget.toggleTheme, isDarkMode: widget.isDarkMode),
      ),
    );
  }

  Future<void> _launchPhoneCall(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print('Cannot launch this API');
    }
  }

  Future<void> _showAddressDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.location_on,
                color: widget.isDarkMode
                    ? Color(0xFF4163CD).withOpacity(0.8)
                    : Color(0xFF4163CD).withOpacity(0.8),
              ),
              SizedBox(width: 8),
              Text('Address'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(Icons.home),
                title: Text('33070 Chera3 el nig'),
              ),
              ListTile(
                leading: Icon(Icons.location_city),
                title: Text('Burkina Sfaxou'),
              ),
              ListTile(
                leading: Icon(Icons.flag),
                title: Text('Tunisia'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Close',
                selectionColor: widget.isDarkMode
                    ? Color(0xFF4163CD).withOpacity(0.8)
                    : Color(0xFF4163CD).withOpacity(0.8),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
