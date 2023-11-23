import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widgets/governorats_dropdown.dart';

class AuthenticationService {
  AuthenticationService();

  checkUserStatus() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('----------------------------User is currently signed out!');
      } else {
        print('--------------------------User is signed in!');
      }
    });
  }

  createAccount(
      {required emailAddress,
      required password,
      required username,
      required phone,
      required location,
      context}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      User? user = credential.user;
      user!.updateDisplayName(username);
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'username': username,
        'email': emailAddress,
        'uid': user.uid,
        'image': null,
        'about': null,
        'phoneNumber': phone,
        'experience': 0,
        'location': location,
        'speciality': null,
        'consultationPrice': 0,
        'isDoctor': true,
        'averageRating': 0,
        'numberOfRatings': 0,
        'patients': 0
      });
      await Future.delayed(Duration(seconds: 1), () {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Color(0xFF4163CD),
            content: Text(
              'Your account has been created successfully !',
              style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
            ),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
          ),
        );
      });
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Color(0xFF4163CD),
            content: Text(
              'The email you provided already used.',
              style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
            ),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
          ),
        );

        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  login({required emailAddress, required password, context}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color(0xFF4163CD),
          content: Text(
            'Invalid login credentials. Please check your email and password.',
            style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
          ),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future loginWithGoogle(context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleUser == null) {
        return;
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  logout() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    if (googleSignIn.currentUser != null) {
      googleSignIn.disconnect();
    }
    await FirebaseAuth.instance.signOut();
  }

  userStatus() {
    FirebaseAuth _auth = FirebaseAuth.instance;
    if (_auth.currentUser == null)
      return true;
    else
      return false;
  }

  resetPassword({required email, context}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFF4163CD),
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Password reset email sent successfully!',
            style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
          ),
          duration: Duration(seconds: 2),
        ),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Error sending password reset email. Please try again.',
            style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
          ),
          duration: Duration(seconds: 2),
        ),
      );
      print(e);
    }
  }

  Future<PermissionStatus> requestLocationPermission() async {
    final status = await Permission.location.request();
    return status;
  }

  Future<void> getCurrentLocation(
      TextEditingController locationController) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        String government = placemark.administrativeArea ?? "N/A";
        String locality = placemark.locality ?? "N/A";

        locationController.text = '$government , $locality';
      } else {
        GovernoratsDropdown();
      }
    } catch (e) {
      print('Error getting location: $e');
    }
  }
}
