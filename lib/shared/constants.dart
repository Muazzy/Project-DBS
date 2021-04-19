import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Color(0xFFEFEBE9),
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF4E342E), width: 1.0),
  ),
);

//Elevated Button Style
ButtonStyle buttonStyleDecoration = ElevatedButton.styleFrom(
  primary: Colors.brown,
  minimumSize: Size(100, 35),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(18.0),
    side: BorderSide(
      color: Colors.brown[800],
    ),
  ),
  padding: EdgeInsets.all(10),
);

//Chai Icon
Widget circleAv = CircleAvatar(
  backgroundColor: Colors.brown[100],
  radius: 80,
  backgroundImage: AssetImage('assets/chai5.1.jpg'),
);

//Centre text
Widget centreText = Center(
  child: Text(
    'CHAI SANGAT',
    style: TextStyle(
      color: Colors.brown[900],
      fontSize: 33,
      fontWeight: FontWeight.bold,
      fontFamily: 'ConcertOne',
      letterSpacing: 1.5,
    ),
  ),
);
