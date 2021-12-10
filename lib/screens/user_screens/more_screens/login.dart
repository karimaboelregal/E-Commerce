import 'package:flutter/material.dart';

import '../globals.dart' as globals;

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 80),
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
            const SizedBox(
              height: 60,
            ),
            Center(child: Text("Username")),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width - 50,
              child: TextFormField(

                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.supervised_user_circle),
                  border: OutlineInputBorder(),
                  hintText: 'Enter your username here',
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(child: Text("Password")),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width - 50,
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "****",
                  prefixIcon: Icon(Icons.security_rounded),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
                width: 100,
                child: ElevatedButton(onPressed: () {}, child: Text("Login"))),
            InkWell(onTap: () {globals.currentTab.value = 5;}, child: Container(height: 30, width: 300, child: Center(child: Text("Dont have an account yet? Click here to signup")))),
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
