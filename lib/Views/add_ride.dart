import 'package:flutter/material.dart';
import 'package:groupool/Views/home.dart';
import 'package:groupool/Views/signup.dart';
import 'package:groupool/util/auth.dart';
import 'package:groupool/util/database.dart';
import 'package:owesome_validator/owesome_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../util/location.dart';
import 'package:groupool/util/location.dart';
import 'package:groupool/theme/rounded_input_field.dart';
//import 'package:groupool/theme/login_background.dart';
import 'package:groupool/theme/rounded_button.dart';

class AddRidePage extends StatefulWidget {
  const AddRidePage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<AddRidePage> {
  String start_location = "";
  String end_location = "";
  String time = "10:00 AM";
  var rideList = [];
  var prefs, row;
  String email = '';
  void initState() {
    getRideData().then(
      (data) {
        setState(() {
          if (data != null) {
            rideList = data;
          }
        });
      },
    );
    initPrefs();
    super.initState();
  }

  void initPrefs() async {
    prefs = await SharedPreferences.getInstance().then((value) => {
          setState(() {
            prefs = value;
            email = '${value.getString('useremail')}';
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('GrouPool'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: size.height * 0.03),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  key: ValueKey('start'),
                  hintText: "Enter Start Location",
                  onChanged: (value) {
                    start_location = value;
                  },
                ),
                RoundedInputField(
                  key: ValueKey('end'),
                  hintText: "Enter End Location",
                  onChanged: (value) {
                    end_location = value;
                  },
                ),
                TextButton(
                  child: const Text('Select time'),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    primary: Colors.pink,
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () => (() async {
                    time = await _selectTime(context) as String;
                    print(time);
                  }()),
                ),
                Text('${time}'),
                TextButton(
                    child: const Text('Continue'),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: Colors.pink,
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () => (() async {
                          if (start_location.isNotEmpty &&
                              end_location.isNotEmpty) {
                            var success_factor = addRide(
                                start_location, end_location, time, email);
                          } else {}
                        }())),
                SizedBox(height: size.height * 0.03),
              ],
            ),
          ),
        ));
  }
}

Future<String> _selectTime(BuildContext context) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  return picked!.format(context);
}
