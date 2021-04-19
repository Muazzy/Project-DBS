import 'package:brew_crew_2/screens/authenticate/register.dart';
import 'package:brew_crew_2/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void switchScreen() {
    setState(() {
      showSignIn = !showSignIn; // setting showSignIn to its opposite value
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(switchScreen: switchScreen);
    } else {
      return Register(switchScreen: switchScreen);
    }
  }
}
