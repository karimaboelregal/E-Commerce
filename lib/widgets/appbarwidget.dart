import 'package:e_commerce1/screens/user_screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget appBarWidget(context) {

  return AppBar(
    elevation: 0.0,
    centerTitle: true,
    title: Image.asset(
      "assets/icon.jpg",
      width: 80,
      height: 40,
    ),
    actions: <Widget>[
      IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        },
        icon: Icon(FontAwesomeIcons.user),
        color: Color(0xFF323232),
      ),
    ],
  );
}