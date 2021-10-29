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
import 'package:groupool/theme/login_background.dart';
import 'package:groupool/theme/rounded_button.dart';

class RideListPage extends StatefulWidget {
  const RideListPage({Key? key}) : super(key: key);
  @override
  State<RideListPage> createState() => _RideListPageState();
}

class _RideListPageState extends State<RideListPage> {
  var rideList = [];
  var sharedPreferences, row;
  String userEmail = '';
  @override
  void initState() {
    getRideData().then(
      (userData) {
        setState(() {

          if (userData != null) {
            rideList = userData;
            print('${rideList}');
          }
        });
      },
    );
    initPrefs();
    super.initState();
  }

  void initPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance().then((value) => {
          setState(() {
            sharedPreferences = value;
            userEmail = '${value.getString('userEmail')}';
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GrouPool"),
        backgroundColor: Colors.pink,
      ),
      body: Center(
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: rideList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text('${rideList[index]['startLocation']} ' +
                        'To' +
                        ' ${rideList[index]['endLocation']}'),
                    subtitle: Text('${rideList[index]['timeOfDay']}' +'\n' + '${rideList[index]['userEmail']}'),
                    trailing: TextButton(
                      child: Text('Request'),
                      onPressed: () {},
                    ),
                    tileColor: Colors.pink.shade50,
                  ));
            }),
      ),
    );
  }
}

Map fetchRideList(dbREF) {
  return {};
}

class CustomTile {
  var startLocation;
  var endLocation;
  var timeOfDay;
  CustomTile(this.startLocation, this.endLocation, this.timeOfDay);
}

List generateTile(rideList) {
  List userList = [];
  for (var i in rideList) {
    userList.add(i);
  }
  print(userList);
  return userList;
}
