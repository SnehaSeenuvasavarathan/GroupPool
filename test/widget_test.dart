// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

//import 'dart:js';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:groupool/util/database.dart';

import 'package:groupool/main.dart';
import 'package:groupool/Views/signup.dart';
import 'package:groupool/Views/signin.dart';
import 'package:groupool/Views/add_ride.dart';
import 'package:groupool/util/auth.dart';
import 'package:groupool/Views/ride_list.dart';

void main() {
  testWidgets('SignUp Page Test', (WidgetTester tester) async {
    MaterialApp signup = MaterialApp(home: SignupPage());
    await tester.pumpWidget(signup);
    var result = EmailFieldValidator.validate('');
    expect(result, "Email cannot be empty");
    expect(find.text('GrouPool'), findsOneWidget);
    var success =
        await registerUser("trialname", "example@gmail.com", "+919790789360");
    expect(success, 'Success');
  });

  testWidgets('SignIn Page Test', (WidgetTester tester) async {
    MaterialApp signInTest = MaterialApp(home: SignInPage());
    await tester.pumpWidget(signInTest);
    expect(find.text('GrouPool'), findsOneWidget);
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            signInWithEmailPassword("test@gmail.com", "Test123!", context)
                .then((user) => {expect(user!.email, "test@gmail.com")});
            // expect(user.email, "findsOneWidget");
            return Placeholder();
          },
        ),
      ),
    ));
  });

  // testWidgets('RideList Page Test', (WidgetTester tester) async {
  //   await Firebase.initializeApp();
  //   MaterialApp ridelist = MaterialApp(home: RideListPage());
  //   await tester.pumpWidget(ridelist);
  //   expect(find.text('GrouPool'), findsOneWidget);
  //   var data = await getRideData();
  //   print(data);
  //   expect(data != null, true);
  // });

  testWidgets('Search Bar Test', (WidgetTester tester) async {
    MaterialApp ridelist = MaterialApp(home: RideListPage());
    await tester.pumpWidget(ridelist);
    expect(find.text('GrouPool'), findsOneWidget);
  });

  testWidgets('Add Ride Test', (WidgetTester tester) async {
    MaterialApp addRideTest = MaterialApp(home: AddRidePage());
    await tester.pumpWidget(addRideTest);
    var result = await addRide(
        "testLocation", "endLocation", "12:00 AM", "someemail@gmail.com");
    expect(result, "Success");
    expect(find.text('GrouPool'), findsOneWidget);
  });
}
