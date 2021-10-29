import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groupool/Views/add_ride.dart';
import 'package:groupool/Views/addride.dart';
import 'package:groupool/Views/editprofile.dart';
import 'package:groupool/Views/ride_list.dart';
import 'package:groupool/Views/signin.dart';
import 'package:groupool/Views/signup.dart';
import 'package:groupool/util/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userEmail = '', name = '';
  var userData = null;
  var rideData = null;
  var sharedPreference, row;
  @override
  void initState() {
    initsharedPreference();
    super.initState();
  }

  void initPrefs() async {
    sharedPreference = await SharedPreferences.getInstance().then((value) => {
          setState(() {
            sharedPreference = value;
            userEmail = '${value.getString('userEmail')}';
          })
        });
    getUserData(userEmail).then(
      (userData) {
        setState(() {
          userData = userData;
        });
      },
    );

    getRideData().then((userData) {
      setState(() {
        rideData = userData;
      });
    });
  }

  String getVal(String key) {
    String value = '';
    SharedPreferences.getInstance().then((sharedPreference) => {
          setState(() async {
            value = '${sharedPreference.getString(key)}';
          })
        });
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(8.0), child: Text('GrouPool'))
          ],
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Profile',
                  style: TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.w600,
                      fontSize: 30),
                )),
            
            Card(
              elevation: 8.0,
              margin:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                  decoration: BoxDecoration(color: Colors.pink[50]),
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.account_circle,
                          size: 100,
                        ),
                        Padding(padding: const EdgeInsets.symmetric(vertical:6.0),child: Text(
                          '${userData['userName']}',
                          style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
                        ),),
                            
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical:8.0),
                          child: Text(userEmail,style: const TextStyle(fontSize: 17
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical:8.0),
                          child: Text('${userData['userPhone']}',style: const TextStyle(fontSize: 15),),
                        )
                      ],
                    ),
                  )),
            ),
            
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(horizontal: 10,vertical:15)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.pink)),
              child: const Text(
                'Edit Profile',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditProfile()),
                );
              },
            )),
          ])),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (i) => {
          if (i == 3)
            {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInPage()),
                  (route) => false)
            }
          else if (i == 2)
            {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddRidePage()))
            }
          else if (i == 1)
            {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RideListPage()))
            }
        },
        items: const [
          
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: "Profile",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.manage_search_rounded),
            label: "Find Rides",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Add Rides",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: "Log Out",
          ),
        ],
      ),
    );
  }
}
