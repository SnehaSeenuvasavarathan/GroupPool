import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:groupool/Views/home.dart';
import 'package:groupool/Views/signin.dart';
import 'package:groupool/Views/signup.dart';
import 'package:groupool/main.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  // Test sign up button functionality to ensure we are redirected ot sign up page
  testWidgets(
    'Once the sign up button is pressed we are taken to the sign up screen and can start signing up',
        (WidgetTester tester) async {
      //load the main page
      await tester.pumpWidget(MyApp());

      // press the sign up button
      //const testKey = Key('Signupbttn');
      await tester.tap(find.byKey(Key('Signupbttn')));
      await tester.pumpAndSettle(); // We wait for animations and such

      // The expected results

      expect(find.byType(SignupPage), findsWidgets);
    },
  );
  // Test log in fuctionality
  testWidgets(
    'We fill in the username and password with valid entries and check and if we are logged into the app',
        (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      // The credentials we will use
       final inputusername = 'randomemail@gmail.com';
       final inputpassword = '_Password123';
      // Key Setup
      const userfieldkey = Key('Usernamefield');
      const passfieldkey = Key('Passwordfield');
      const buttnkey = Key('loginbttn');

      // Put the credentials into the right fields
      await tester.enterText(find.byKey(userfieldkey), inputusername);
      await tester.enterText(find.byKey(passfieldkey), inputpassword);

      // Press the sign in button
      await tester.tap(find.byKey(buttnkey));
      await tester.pumpAndSettle();

      // Expect empty sign up page and widgets on home page
          expect (find.byType(HomePage), findsWidgets);
          expect (find.byType(SignInPage), findsNothing);

    },


  );
}