import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupool/Views/rideDetail.dart';
import 'package:groupool/util/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RideCart extends StatefulWidget {
  const RideCart({Key? key}) : super(key: key);

  @override
  _RideCartState createState() => _RideCartState();
}

class _RideCartState extends State<RideCart> {
  var rideList = [];
  var prefs, row;
  String email = '';
  @override
  void initState() {
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
    getCartData(email).then(
      (data) {
        setState(() {
          if (data != null) {
            rideList = data;
          }
        });
      },
    );
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
                    title: Text('${rideList[index]['start']} ' +
                        'To' +
                        ' ${rideList[index]['end']}'),
                    subtitle: Text('${rideList[index]['time']}' +
                        '\n' +
                        '${rideList[index]['email']}'),
                    trailing: TextButton(
                        child: Text('Details'),
                        key: ValueKey('detailButton'),
                        onPressed: () {
                          getRideById('${rideList[index]['id']}').then(
                            ////////////////ERROR HERE

                            (data) {
                              if (data != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => rideDetail(
                                              ride: data,
                                            )));
                              }
                            },
                          );
                        }),
                    tileColor: Colors.pink.shade50,
                  ));
            }),
      ),
    );
  }
}
