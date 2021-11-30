import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:groupool/main.dart';
import 'package:owesome_validator/owesome_validator.dart';

void main() {

  test('Test if the validator for the password entered is valid', (){
    //Run
    var result = OwesomeValidator.password('test', '${OwesomeValidator.passwordMinLen8withCamelAndSpecialChar}');
    //What to expect
  expect(result, false);
  });
  test('Test if the validator for the email entered is valid', (){
    //Run
    var result = OwesomeValidator.email('test', '${OwesomeValidator.patternEmail}');
    //What to expect
    expect(result, false);
  });
  test('Test if the validator for the name entered is valid', (){
    //Run
    var result = OwesomeValidator.name('password123_', '${OwesomeValidator.patternNameOnlyChar}');
    //What to expect
    expect(result, false);
  });
  test('Test if the validator for the phone entered is valid', (){
    //Run
    var result = OwesomeValidator.phone('test', '${OwesomeValidator.patternPhone}');
    //What to expect
    expect(result, false);
  });
}