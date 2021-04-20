import 'dart:math';

import 'package:brew_crew_2/models/user.dart';
import 'package:brew_crew_2/services/database.dart';
import 'package:brew_crew_2/shared/constants.dart';
import 'package:brew_crew_2/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: Text(
                      'Update your Chai Prefrences',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 10.0),
                  Flexible(
                    flex: 2,
                    child: DropdownButtonFormField(
                      value: _currentSugars ?? userData.sugars,
                      decoration: textInputDecoration,
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                          value: sugar,
                          child: Text('$sugar sugars'),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _currentSugars = val),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Flexible(
                    flex: 2,
                    child: Row(
                      children: [
                        Text(
                          'Strength:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.brown[
                                  _currentStrength ?? userData.strength]),
                        ),
                        Slider(
                          value: (_currentStrength ?? userData.strength)
                              .toDouble(),
                          activeColor: Colors
                              .brown[_currentStrength ?? userData.strength],
                          inactiveColor: Colors
                              .brown[_currentStrength ?? userData.strength],
                          min: 100.0,
                          max: 900.0,
                          divisions: 8,
                          onChanged: (val) =>
                              setState(() => _currentStrength = val.round()),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.brown, // background
                          onPrimary: Colors.white, // foreground
                        ),
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await DatabaseService(uid: user.uid).updateUserData(
                                _currentName ?? userData.name,
                                _currentSugars ?? userData.sugars,
                                _currentStrength ?? userData.strength);
                            Navigator.pop(context);
                          }
                        }),
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
