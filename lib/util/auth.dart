import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

String? userID;
String? userEmail;
Future<User?> signInWithEmailPassword(
    String userEmail, String userPassword, BuildContext context) async {
  await Firebase.initializeApp();
  User? user;

  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      userEmail: userEmail,
      userPassword: userPassword,
    );
    user = userCredential.user;

    if (user != null) {
      userID = user.userID;
      userEmail = user.userEmail;

      SharedPreferences sharedPreference = await SharedPreferences.getInstance();
      await sharedPreference.setBool('auth', true);
      await sharedPreference.setString('useremail', userEmail.toString());
      await sharedPreference.setString('userID', userID.toString());
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('User Not Found')));
    } else if (e.code == 'wrong-password') {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Wrong Password')));
    }
  }

  return user;
}

Future<User?> registerWithEmailPassword(String userEmail, String userPassword) async {
  // Initialize Firebase
  await Firebase.initializeApp();
  User? user;

  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      userEmail: userEmail,
      userPassword: userPassword,
    );

    user = userCredential.user;

    if (user != null) {
      userID = user.userID;
      userEmail = user.userEmail;
    }
  } catch (e) {
    print(e);
  }

  return user;
}
