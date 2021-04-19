import 'package:brew_crew_2/models/brew.dart';
import 'package:brew_crew_2/screens/home/settings_form.dart';
import 'package:brew_crew_2/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew_2/services/database.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew_2/screens/home/brew_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text(
            'Chai Sangat',
            style: TextStyle(
              color: Colors.brown[100],
              fontFamily: 'ConcertOne',
              fontSize: 25,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.brown[400],
          elevation: 2.0,
          actions: <Widget>[
            TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              label: Text(
                'Logout',
                style: TextStyle(color: Colors.brown[900]),
              ),
              icon: Icon(
                Icons.person,
                color: Colors.brown[900],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.brown[400],
          hoverColor: Colors.brown,
          focusColor: Colors.brown[700],
          child: Icon(
            Icons.settings,
            color: Colors.brown[100],
          ),
          onPressed: _showSettingsPanel,
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/coffee_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: BrewList()),
      ),
    );
  }
}
