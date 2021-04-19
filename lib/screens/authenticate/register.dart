import 'package:brew_crew_2/services/auth.dart';
import 'package:brew_crew_2/shared/constants.dart';
import 'package:brew_crew_2/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function switchScreen;
  Register({this.switchScreen});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //textForm fields
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            body: SafeArea(
              child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        circleAv,
                        centreText,
                        SizedBox(height: 35),
                        //Email
                        TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Email'),
                          validator: (val) =>
                              val.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Password'),
                          obscureText: true,
                          validator: (val) => val.length < 6
                              ? 'Password must be 6 chars long'
                              : null,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                        ),
                        SizedBox(height: 17),
                        //sign up button
                        ElevatedButton(
                          style: buttonStyleDecoration,
                          onPressed: () async {
                            //this is to validate the validator conditions
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      email, password);
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error = 'Email or Password is not valid';
                                });
                              }
                            }
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.brown[100],
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 7),
                        Text(
                          error,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                color: Colors.brown[900],
                                fontSize: 14,
                              ),
                            ),
                            TextButton(
                                onPressed: widget.switchScreen,
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: Colors.brown[900],
                                  ),
                                )),
                          ],
                        )
                      ],
                    ),
                  )),
            ),
          );
  }
}
