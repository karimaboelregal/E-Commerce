import 'package:flutter/material.dart';

import '../globals.dart' as globals;

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: Column(
              children: const [
                Icon(
                  Icons.shopping_basket,
                  size: 65.0,
                  color: Color(0xff0088ff),
                ),
                Text(
                  "Ecommerce",
                  style: TextStyle(color: Color(0xff0088ff), fontSize: 35.0),
                ),
              ],
            )),
            const SizedBox(height: 60,),
            Center(child: Text("Username")),
            Container(width: MediaQuery.of(context).size.width - 50, child: TextField(),),
            SizedBox(height:20),
            Center(child: Text("Password")),
            Container(width: MediaQuery.of(context).size.width - 50, child: TextField(),),
            SizedBox(height:20),
            Container(width: 100, child: ElevatedButton(onPressed: () {}, child: Text("Login"))),
            Text("Dont have an account yet? Click here to signup"),
            WillPopScope(
                onWillPop: () {
                  print("hi");
                  globals.currentTab.value = 3;
                  return Future.value(false);
                },
                child: Text('')),
          ],
        ),
      ),
    );
  }
}
