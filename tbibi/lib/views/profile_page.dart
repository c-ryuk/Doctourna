// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:tbibi/views/appoinment_page.dart';
import 'package:tbibi/views/edit_profile_page.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          buildTop(),
          buildContent(),
        ]),
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
            children: const [
              Icon(
                Icons.healing_outlined,
                color: Colors.lightGreen,
                size: 25,
              ),
              SizedBox(width: 8),
              Text(
                'something',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ],
          ),
          SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSocialIcon(FontAwesome.slack),
              SizedBox(width: 12),
              buildSocialIcon(FontAwesome.facebook),
              SizedBox(width: 12),
              buildSocialIcon(FontAwesome.linkedin),
              SizedBox(width: 12),
              buildSocialIcon(FontAwesome.github),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.phone,
                size: 30,
                color: Colors.lightGreen,
              ),
              SizedBox(width: 8),
              Text(
                '22 555 888',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.lightGreen,
                ),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: () async {
                  final Uri url = Uri(scheme: 'tel', path: '22 555 888');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    print('cannot lunch this api');
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen,
                  onPrimary: Colors.white,
                ),
                child: Text('Call Me'),
              ),
            ],
          ),
          SizedBox(height: 26),
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'About Me',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'I am a passionate developer who loves Flutter and creating amazing apps.',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          buildAddressSection(),
          SizedBox(width: 36),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AppointmentBookingPage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.lightGreen,
              onPrimary: Colors.white,
            ),
            child: Text('Take Appointment'),
          ),
        ],
      );

  Widget buildTop() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 144 / 2),
          child: buildCoverImage(),
        ),
        Positioned(
          top: 280 - 144 / 2,
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
                      color: Colors.lightGreen,
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
          top: 30,
          left: 16,
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }

  Widget buildCoverImage() => Container(
        color: Colors.lightGreen,
        child: Image.network(
          'https://res.cloudinary.com/dhzlfojtv/image/upload/v1696246033/istockphoto-831557666-612x612-removebg-preview_zs3zjc.png',
          width: double.infinity,
          height: 280,
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

  Widget buildSocialIcon(IconData icon) => CircleAvatar(
      radius: 25,
      child: Material(
        shape: CircleBorder(),
        clipBehavior: Clip.hardEdge,
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Center(
              child: Icon(
            icon,
            size: 32,
          )),
        ),
      ));

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
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget buildAddressSection() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Address',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: Colors.black,
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                '123 Main Street, City, Country',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
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
}
