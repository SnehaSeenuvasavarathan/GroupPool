import 'package:flutter/material.dart';
import 'package:groupool/Views/signin.dart';
import 'Views/signin.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {}

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'GrouPool',
            theme: ThemeData(
              primarySwatch: Colors.pink,
            ),
            home: SignInPage(),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container();
      },
    );
    // return MaterialApp(
    //   title: 'GrouPool',
    //   theme: ThemeData(
    //     primarySwatch: Colors.pink,
    //   ),
    //   home: SignInPage(),
    // );
  }
}
