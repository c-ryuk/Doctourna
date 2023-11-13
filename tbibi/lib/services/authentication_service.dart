import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      context}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      User? user = credential.user;
      user!.updateDisplayName(username);
      await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
        'username': username,
        'email': emailAddress,
        'password': username,
      });
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
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
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Invalid login credentials. Please check your email and password.'),
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
}
