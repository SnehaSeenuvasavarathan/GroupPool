import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:groupool/main.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  // Test sign up functionality
  testWidgets('Once the sign up button is pressed we are taken to the sign up screen and can start signing up',
        (WidgetTester tester) async{
        await tester.pumpWidget(widget)
        },);
  // Test log in fuctionality
}