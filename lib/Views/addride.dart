// import 'package:flutter/material.dart';
// import 'package:groupool/Views/home.dart';
// import 'package:groupool/Views/signup.dart';
// import 'package:groupool/util/auth.dart';
// import 'package:owesome_validator/owesome_validator.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../util/location.dart';

// class AddRidePage extends StatefulWidget {
//   const AddRidePage({Key? key}) : super(key: key);

//   @override
//   _State createState() => _State();
// }

// class _State extends State<AddRidePage> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController seatingController = TextEditingController();
//   void printLocation() async {
    
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('GrouPool'),
//         ),
//         body: Padding(
//             padding: const EdgeInsets.all(10),
//             child: ListView(
//               children: <Widget>[
//                 Container(
//                     alignment: Alignment.center,
//                     padding: const EdgeInsets.all(10),
//                     child: const Text(
//                       'Add Ride',
//                       style: TextStyle(
//                           color: Colors.pink,
//                           fontWeight: FontWeight.w600,
//                           fontSize: 30),
//                     )),
//                 const Divider(
//                   height: 10,
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   child: TextField(
//                     controller: emailController,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Source',
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                   child: TextField(
//                     obscureText: true,
//                     controller: passwordController,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Destination',
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   child: TextField(
//                     controller: seatingController,
//                     keyboardType: TextInputType.number,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Seating Availability',
//                     ),
//                   ),
//                 ),

                
//                 Container(
//                     height: 50,
//                     padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                     child: ElevatedButton(
//                       style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all<Color>(Colors.pink)),
//                       child: const Text('Add'),
//                       onPressed: () {},
//                     )),
//                 // ignore: avoid_unnecessary_containers
                
//               ],
//             )));
//   }
// }
