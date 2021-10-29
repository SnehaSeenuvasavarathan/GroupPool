import 'package:flutter/material.dart';
import 'package:groupool/Views/home.dart';
import 'package:groupool/Views/signup.dart';
import 'package:groupool/util/auth.dart';
import 'package:groupool/util/database.dart';
import 'package:owesome_validator/owesome_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('GrouPool'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Log-In',
                      style: TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.w600,
                          fontSize: 30),
                    )),
                const Divider(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                  },
                  style: TextButton.styleFrom(primary: Colors.pink),
                  child: const Text('Forgot Password'),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.pink)),
                      child: const Text('Login'),
                      onPressed: () {
                        if (!OwesomeValidator.name(emailController.text,
                            '${OwesomeValidator.patternEmail}')) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Invalid Name')));
                        } else if (!OwesomeValidator.password(
                            passwordController.text,
                            '${OwesomeValidator.passwordMinLen8withCamelAndSpecialChar}')) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Invalid Pwd')));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Valid Pwd')));
                          signInWithEmailPassword(
                                  emailController.text, passwordController.text, context)
                              .then((user)=>  {
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const HomePage()), (route) => false)
                              });
                        }
                      },
                    )),
                Container(
                    child: Row(
                  children: <Widget>[
                    const Text("Does not have account?"),
                    FlatButton(
                      textColor: Colors.blue,
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage()),
                        );
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }
}
