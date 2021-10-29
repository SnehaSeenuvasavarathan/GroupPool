import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
Future<void> storeValues() async {
  String userID = '', userEmail = '';
  SharedPreferences.getInstance().then((sharedPreference) => {
        firestore.collection('User Profile').add({
          'userID': '${sharedPreference.getString('userID')}',
          'userEmail': '${sharedPreference.getString('userEmail')}'
        }).then((value) => {print('Stored Value in DB')})
      });
}

Future<void> registerUser(String userName, String userEmail, String userPhone) async {
  SharedPreferences.getInstance().then((sharedPreference) => {
        firestore.collection('User Profile').add({
          'userEmail': '${userEmail}',
          'userName': '${userName}',
          'userPhone': '${userPhone}'
        }).then((value) => {print('User Registered in DB')})
      });
}

Future<void> addRide(
    String startLocation, String endLocation, String timeOfDay, String userEmail) async {
  SharedPreferences.getInstance().then((sharedPreference) => {
        firestore.collection('ride-table').add({
          'startLocation': '${startLocation}',
          'endLocation': '${endLocation}',
          'timeOfDay': '${timeOfDay}',
          'userEmail': '${userEmail}'
        }).then((value) => {print('Added Ride in DB')})
      });
}

Future<dynamic> getUserData(String email) async {
  try {
    var snapshot = await FirebaseFirestore.instance
        .collection('User Profile')
        .where('userEmail', isEqualTo: userEmail)
        .get();

    return snapshot.docs[0].data();
  } catch (e) {
    print(e.toString());
  }
}

Future<List?> getRideData() async {
  List rideList = [];
  try {
    var snapshot =
        await FirebaseFirestore.instance.collection('ride-table').get();
    for (var doc in snapshot.docs) {
      rideList.add(doc.data());
    }
    return rideList;
  } catch (e) {
    print(e.toString());
  }
}
