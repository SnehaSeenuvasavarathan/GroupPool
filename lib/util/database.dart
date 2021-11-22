import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
Future<void> storeValues() async {
  String uid = '', email = '';
  SharedPreferences.getInstance().then((prefs) => {
        firestore.collection('User Profile').add({
          'UID': '${prefs.getString('uid')}',
          'Email': '${prefs.getString('useremail')}'
        }).then((value) => {print('lol')})
      });
}

Future<void> registerUser(String name, String email, String phone) async {
  //String uid='', email='', name = '', phone = '';
  SharedPreferences.getInstance().then((prefs) => {
        firestore.collection('User Profile').add({
          'Email': '${email}',
          'Name': '${name}',
          'Phone': '${phone}'
        }).then((value) => {print('User Registered in DB')})
      });
}

Future<void> addRide(
    String start, String end, String time, String email) async {
  //String start='', end='', name = '', time = '';
  SharedPreferences.getInstance().then((prefs) => {
        firestore.collection('ride-table').add({
          'start': '${start}',
          'end': '${end}',
          'time': '${time}',
          'email': '${email}'
        }).then((value) => {print('Added Ride in DB')})
      });
}

Future<dynamic> getUserData(String email) async {
  Future<Map> data;
  try {
    var snapshot = await FirebaseFirestore.instance
        .collection('User Profile')
        .where('Email', isEqualTo: email)
        .get();

    return snapshot.docs[0].data();
  } catch (e) {
    print(e.toString());
  }
}

Future<List?> getRideData() async {
  Future<Map> data;
  List rideList = [];
  Map rideList1 = {};
  try {
    var snapshot =
        await FirebaseFirestore.instance.collection('ride-table').get();
    for (var doc in snapshot.docs) {
      rideList.add(doc.data());
      print("InLoop");
      print(doc.data());
    }
    return rideList;
  } catch (e) {
    print(e.toString());
  }
}
