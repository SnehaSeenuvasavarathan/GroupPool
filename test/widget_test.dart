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
import 'package:groupool/Views/home.dart';
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
    expect(find.text('Log-In'), findsOneWidget);
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
    expect(find.byIcon(Icons.search), findsOneWidget);
  });

  testWidgets('Add Ride Test', (WidgetTester tester) async {
    MaterialApp addRideTest = MaterialApp(home: AddRidePage());
    await tester.pumpWidget(addRideTest);
    expect(find.text('GrouPool'), findsOneWidget);
    var result = await addRide(
        "testLocation", "endLocation", "12:00 AM", "someemail@gmail.com");
    expect(result, "Success");
  });

  testWidgets('Integration Test', (WidgetTester tester) async {
    MaterialApp signup = MaterialApp(home: SignupPage());
    await tester.pumpWidget(signup);

    final Finder emailID = find.byKey(ValueKey('emailID'));
    final Finder userName = find.byKey(ValueKey('userName'));
    final Finder password = find.byKey(ValueKey('password'));
    final Finder confirmPassword = find.byKey(ValueKey('confirmPassword'));
    final Finder number = find.byKey(ValueKey('number'));
    expect(emailID, findsOneWidget);
    expect(userName, findsOneWidget);
    expect(password, findsOneWidget);
    expect(confirmPassword, findsOneWidget);
    expect(number, findsOneWidget);

    // Enter text
    await tester.enterText(emailID, 'test@test.com');
    await tester.enterText(userName, 'testuser');
    await tester.enterText(password, 'Password123&');
    await tester.enterText(confirmPassword, 'Password123&');
    await tester.enterText(number, '+918909876234');

    final Finder submitButton = find.byKey(ValueKey('submit'));
    await tester.tap(submitButton);

    MaterialApp signInTest = MaterialApp(home: SignInPage());
    await tester.pumpWidget(signInTest);
    final Finder emailID2 = find.byKey(ValueKey('userName'));
    final Finder password2 = find.byKey(ValueKey('password'));
    final Finder loginButton = find.byKey(ValueKey('login'));
    expect(emailID2, findsOneWidget);
    expect(password2, findsOneWidget);
    await tester.enterText(emailID2, 'test@test.com');
    await tester.enterText(password2, 'Password123&');
    await tester.tap(loginButton);

    MaterialApp addRideTest = MaterialApp(home: AddRidePage());
    await tester.pumpWidget(addRideTest);
    var result = await addRide(
        "testLocation", "endLocation", "12:00 AM", "someemail@gmail.com");
    expect(result, "Success");
  });
}
