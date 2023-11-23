// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:tbibi/views/appoitments/appoinment_page.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePageNormal extends StatefulWidget {
  final String userId;
  final BuildContext context;
  final Function toggleTheme;
  final bool isDarkMode;

  ProfilePageNormal({
    Key? key,
    required this.userId,
    required this.context,
    required this.toggleTheme,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  _ProfilePageNormalState createState() => _ProfilePageNormalState();
}

class _ProfilePageNormalState extends State<ProfilePageNormal> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic> userData = {};
  Map<String, dynamic> userRating = {};

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      DocumentSnapshot userSnapshot =
          await _firestore.collection('users').doc(widget.userId).get();

      QuerySnapshot ratingSnapshot = await _firestore
          .collection('ratings')
          .where('userId', isEqualTo: widget.userId)
          .get();
      String raterId = FirebaseAuth.instance.currentUser?.uid ?? '';

      QuerySnapshot rateSnapshot = await _firestore
          .collection('ratings')
          .where('raterId', isEqualTo: raterId)
          .where('userId', isEqualTo: widget.userId)
          .get();

      if (userSnapshot.exists) {
        setState(() {
          userData = userSnapshot.data() as Map<String, dynamic>;

          if (ratingSnapshot.docs.isNotEmpty) {
            double totalRating = ratingSnapshot.docs
                .map((doc) => doc['rating'] as double)
                .reduce((value, element) => value + element);
            double averageRating = totalRating / ratingSnapshot.docs.length;
            userData['averageRating'] = averageRating;
          }
          if (rateSnapshot.docs.isNotEmpty) {
            userRating = rateSnapshot.docs.first.data() as Map<String, dynamic>;
          }
        });
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  Future<void> _updateRating(double rating) async {
    try {
      String raterId = FirebaseAuth.instance.currentUser?.uid ?? '';

      QuerySnapshot existingRatingQuery = await _firestore
          .collection('ratings')
          .where('raterId', isEqualTo: raterId)
          .where('userId', isEqualTo: widget.userId)
          .get();

      if (existingRatingQuery.docs.isNotEmpty) {
        DocumentSnapshot existingRatingDoc = existingRatingQuery.docs.first;
        double existingRatingValue = existingRatingDoc['rating'];

        double newAverageRating =
            ((userData['averageRating'] ?? 0) + rating - existingRatingValue);
        await existingRatingDoc.reference.update({
          'rating': rating,
        });

        await _firestore.collection('users').doc(widget.userId).update({
          'averageRating': newAverageRating,
        });
      } else {
        await _firestore.collection('ratings').add({
          'userId': widget.userId,
          'raterId': raterId,
          'rating': rating,
        });

        await _firestore.collection('users').doc(widget.userId).update({
          'averageRating': ((userData['averageRating'] ?? 0) *
                      (userData['numberOfRatings'] ?? 0) +
                  rating) /
              ((userData['numberOfRatings'] ?? 0) + 1),
          'numberOfRatings': (userData['numberOfRatings'] ?? 0) + 1,
        });
      }

      await _loadUserData();
    } catch (e) {
      print('Error updating rating: $e');
    }
  }

  bool get userLoggedIn => FirebaseAuth.instance.currentUser != null;

  @override
  Widget build(BuildContext context) {
    if (userData.isEmpty) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(padding: EdgeInsets.zero, children: [
          buildTop(),
          buildContent(),
        ]),
      ),
      bottomNavigationBar: userLoggedIn
          ? SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(15),
                height: 150,
                decoration: BoxDecoration(
                  color: widget.isDarkMode
                      ? Colors.black.withOpacity(0.3)
                      : Colors.white,
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
                            color:
                                widget.isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        Text(
                          '\$${userData['consultationPrice'] ?? '00'}',
                          style: TextStyle(
                            color:
                                widget.isDarkMode ? Colors.white : Colors.black,
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
            )
          : Container(
              padding: EdgeInsets.all(15),
              height: 130,
              decoration: BoxDecoration(
                color: widget.isDarkMode
                    ? Colors.black.withOpacity(0.3)
                    : Colors.white,
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
                          color:
                              widget.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      Text(
                        '\$${userData['consultationPrice'] ?? '00'}',
                        style: TextStyle(
                          color:
                              widget.isDarkMode ? Colors.white : Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
            userData['username'] ?? '',
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
                userData['speciality'] ?? 'No speciality',
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
                _launchPhoneCall(userData['phoneNumber'] ?? '');
              }),
              SizedBox(width: 12),
              buildSocialIcon(FontAwesome.facebook),
              SizedBox(width: 12),
              buildSocialIcon(FontAwesome.location_arrow),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Column(
            children: [
              userLoggedIn
                  ? RatingBar.builder(
                      initialRating: userRating['rating']?.toDouble() ?? 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        _updateRating(rating);
                      },
                    )
                  : SizedBox(height: 8),
              Text(
                '(${userData['numberOfRatings'] ?? 0} raters)',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildCountWidget("Patients", userData['patients'] ?? 00),
              buildCountWidget("Experience", userData['experience'] ?? 00),
              buildCountWidget("Rating", userData['averageRating'] ?? 0),
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
                  userData['about'] ?? 'Write something about you!',
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
            ],
          ),
        ),
        Positioned(
          top: 40,
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
        backgroundColor: Colors.white,
        radius: 70,
        backgroundImage: userData['image'] != null
            ? NetworkImage(userData['image']) as ImageProvider
            : AssetImage('assets/Doc_icon.jpg'),
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

  Widget buildCountWidget(String label, num count) {
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
            count.toStringAsFixed(2),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
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

  void _navigateToAppoinmentPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AppointmentBookingPage(
            userId: userData['uid'],
            toggleTheme: widget.toggleTheme,
            isDarkMode: widget.isDarkMode),
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
                title: Text(userData['location'] ?? 'N/A'),
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
