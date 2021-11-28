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
  final TextEditingController _filter = new TextEditingController();
  var rideList = [];
  Widget _appBarTitle = new Text('Groupool');
  Icon _searchIcon = new Icon(Icons.search, color: Colors.white);
  var prefs, row;
  String email = '';
  String _searchText = "";
  List filteredRides = [];

  _RideListPageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredRides = rideList;
          // filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  void initState() {
    getRideData().then(
      (data) {
        setState(() {
          //rideData = data;
          print('HEREEEEEEEE');
          //print('${data}');
          if (data != null) {
            rideList = data;
            filteredRides = rideList;
            print('${rideList}');
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
    if (!(_searchText.isEmpty)) {
      print("filtering");
      List tempList = [];
      for (int i = 0; i < rideList.length; i++) {
        if (rideList[i]['start']
                .toLowerCase()
                .contains(_searchText.toLowerCase()) ||
            rideList[i]['end']
                .toLowerCase()
                .contains(_searchText.toLowerCase())) {
          tempList.add(rideList[i]);
        }
      }
      filteredRides = tempList;
    } else {
      print("resetting");
      filteredRides = rideList;
    }
    return Scaffold(
      appBar: AppBar(
        title: _appBarTitle,
        backgroundColor: Colors.pink,
        actions: <Widget>[
          IconButton(
              icon: _searchIcon,
              onPressed: () {
                setState(() {
                  print("Search");
                  if (this._searchIcon.icon == Icons.search) {
                    print("s2");
                    this._searchIcon =
                        new Icon(Icons.close, color: Colors.white);
                    print("changing icon...");
                    this._appBarTitle = new TextField(
                      controller: _filter,
                      style: TextStyle(color: Colors.white),
                      decoration: new InputDecoration(
                        prefixIcon: new Icon(Icons.search, color: Colors.white),
                        hintText: 'Search...',
                      ),
                    );
                  } else {
                    print("Close mode");
                    this._searchIcon =
                        new Icon(Icons.search, color: Colors.white);
                    this._appBarTitle = new Text('Groupool');
                    _searchText = "";
                    _filter.clear();
                  }
                });
              }),
        ],
      ),
      body: Center(
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: filteredRides.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text('${filteredRides[index]['start']} ' +
                        'To' +
                        ' ${filteredRides[index]['end']}'),
                    subtitle: Text('${filteredRides[index]['time']}' +
                        '\n' +
                        '${filteredRides[index]['email']}'),
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
  var start;
  var end;
  var time;
  CustomTile(this.start, this.end, this.time);
}

List generateTile(rideList) {
  List l = [];
  for (var i in rideList) {
    print("in List");
    l.add(i);
  }
  print(l);
  return l;
}
