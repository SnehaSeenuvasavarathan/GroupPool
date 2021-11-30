// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

//import 'dart:js';
//import 'dart:html';
import 'dart:async';
import 'package:fake_async/fake_async.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:groupool/Views/myRides.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:groupool/Views/rideDetail.dart';
import 'package:groupool/util/database.dart';

import 'package:groupool/main.dart';
import 'package:groupool/Views/home.dart';
import 'package:groupool/Views/signup.dart';
import 'package:groupool/Views/signin.dart';
import 'package:groupool/Views/add_ride.dart';
import 'package:groupool/util/auth.dart';
import 'package:groupool/Views/ride_list.dart';
import 'package:groupool/Views/rideDetail.dart';
import 'package:mockito/mockito.dart';

import 'package:path/path.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  var mockObserver = MockNavigatorObserver();

  setUp(() {
    mockObserver = MockNavigatorObserver();
  });

  Object OpenCheck() {
    var obj = callOpenCheck();
    obj.openCheckout();
    return true;
  }

  testWidgets('Integration Tests Sign-Up/Sign-In', (WidgetTester tester) async {
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

    MaterialApp signInTest = MaterialApp(
      home: SignInPage(),
      navigatorObservers: [mockObserver],
    );
    await tester.pumpWidget(signInTest);
    final Finder emailID2 = find.byKey(ValueKey('userName'));
    final Finder password2 = find.byKey(ValueKey('password'));
    final Finder loginButton = find.byKey(ValueKey('login'));
    expect(emailID2, findsOneWidget);
    expect(password2, findsOneWidget);
    await tester.enterText(emailID2, 'alpadave@gmail.com');
    await tester.enterText(password2, 'Alpa123!');
    await tester.tap(loginButton);
    await tester.pumpAndSettle();
    //FOR HOME
    // MaterialApp homePageTest = MaterialApp(
    //     home: HomePage(
    //   userdata: {
    //     'Email': 'jahanvidave78247@gmail.com',
    //     'Phone': '+9188369819701',
    //     'Name': 'Jahanvi Dave'
    //   },
    // ));
    // try {
    //   //await tester.pumpWidget(homePageTest);
    //   await tester.pump(new Duration(milliseconds: 100));
    // } catch (e) {
    //   print('pass');
    // }

    MaterialApp ridecart = MaterialApp(home: RideCart());
    await tester.pumpWidget(ridecart);
    print('check add ride');
    expect(find.text('GrouPool'), findsOneWidget);
    Map? rideList = {
      'end': 'ABC',
      'start': 'XYZ',
      'email': 'abc@gmail.com',
      'time': '1:28 AM',
      'riderList': ['test@test.com']
    };
    MaterialApp ridedetail = MaterialApp(home: rideDetail(ride: rideList));
    await tester.pumpWidget(ridedetail);
    expect(find.text('Pay'), findsOneWidget);
    final Finder payButton = find.text('Pay');
    await tester.tap(payButton);
    var bool = OpenCheck();
    print(bool);
    expect(bool, true);
    print('END');

    MaterialApp addRideTest = MaterialApp(home: AddRidePage());
    await tester.pumpWidget(addRideTest);
    print('AWAIT ADD RIDE');
    print(addRideTest.home);
    var result = await addRide(
        "testLocation", "endLocation", "12:00 AM", "someemail@gmail.com");
    expect(result, "Success");
  });
}
