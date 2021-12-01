import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:groupool/main.dart';
import 'package:owesome_validator/owesome_validator.dart';

void main() {

  test('Test if the validator for the password entered is valid', (){
    //Setup lists
    var validlistpassword = ['_Password123!','#ValidPass123','okPassw0rd!'];
    var invalidListPassword = ['test', 'Test123456', 'ShouldNotWork_'];
    //Run
    // If we test invalid results we should get a false result from validator
    for (var i =0; i<3;i++) {
      var result = OwesomeValidator.password(
          invalidListPassword[i], '${OwesomeValidator.passwordMinLen8withCamelAndSpecialChar}');
      //What to expect
      expect(result, false);
    }
    //If we test valid inputs we should get a true result from validator

    for (var j =0; j<3;j++) {
      var result = OwesomeValidator.password(
          validlistpassword[j], '${OwesomeValidator.passwordMinLen8withCamelAndSpecialChar}');
      //What to expect
      expect(result, true);
    }
  });
  test('Test if the validator for the email entered is valid', (){
    //Setup lists
    var validlistemail = ['testemail@gmail.com','ValidEmail05@gmail.com','Email_tester@gmail.com'];
    var invalidListemail = ['test.com', 'bsemail', 'ShouldNotWork_'];
    //Run

    // If we test invalid results we should get a false result from validator
    for (var i =0; i<3;i++) {
      var result = OwesomeValidator.email(
          invalidListemail[i], '${OwesomeValidator.patternEmail}');
      //What to expect
      expect(result, false);
    }
    //If we test valid inputs we should get a true result from validator
    for (var j =0; j<3;j++) {
      var result = OwesomeValidator.email(
          validlistemail[j], '${OwesomeValidator.patternEmail}');
      //What to expect
      expect(result, true);
    }
  });
  test('Test if the validator for the username entered is valid', (){
    var validlistusername = ['namesNames','Testsnamereallylong','S'];
    var invalidListusername = ['_namesNames', 'Numbersinnames0123', '?Does_it_Work?123'];
    //Run

    // If we test invalid results we should get a false result from validator
    for (var i =0; i<3;i++) {
      var result = OwesomeValidator.name(
          invalidListusername[i], '${OwesomeValidator.patternNameOnlyChar}');
      //What to expect
      expect(result, false);
    }
    //If we test valid inputs we should get a true result from validator

    for (var j =0; j<3;j++) {
      var result = OwesomeValidator.name(
          validlistusername[j], '${OwesomeValidator.patternNameOnlyChar}');
      //What to expect
      expect(result, true);
    }
  });
  test('Test if the validator for the phone number entered is valid', (){
    var validlistphone = ['12345678900','01010101234','11111111111'];
    var invalidListphone = ['12345.6789', 'Symbolsandwords#', '1234'];
    //Run
    // If we test invalid results we should get a false result from validator
    for (var i =0; i<3;i++) {
      var result = OwesomeValidator.phone(
          invalidListphone[i], '${OwesomeValidator.patternPhone}');
      //What to expect
      expect(result, false);
    }
    //If we test valid inputs we should get a true result from validators

    for (var j =0; j<3;j++) {
      var result = OwesomeValidator.phone(
          validlistphone[j], '${OwesomeValidator.patternPhone}');
      //What to expect
      expect(result, true);
    }
  });
}