import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 60,),
        Center(child: Column(children: [
          Icon(
            Icons.shopping_basket,
            size: 65.0,
            color: Color(0xff0088ff),
          ),
          Text(
            "Ecommerce",
            style: TextStyle(color: Color(0xff0088ff), fontSize: 35.0),
          ),

        ],)),
        SizedBox(height: 50,),
        ListTile(
          leading: Icon(Icons.info, color: Color(0xff0088ff),), title: Text("News"), onTap: () {},),
        ListTile(
          leading: Icon(Icons.contact_mail, color: Color(0xff0088ff)), title: Text("Contact us"), onTap: () {},),
        ListTile(
          leading: Icon(Icons.login, color: Color(0xff0088ff)), title: Text("Login"), onTap: () {},),
        ListTile(
          leading: Icon(Icons.app_registration, color: Color(0xff0088ff)), title: Text("Register"), onTap: () {},),
      ],
    );
  }

}

