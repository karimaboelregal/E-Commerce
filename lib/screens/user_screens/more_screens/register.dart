import 'package:flutter/material.dart';

import '../globals.dart' as globals;

class Register extends StatelessWidget {
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
            Center(child: Text("Email")),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width - 50,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter your e-mail address here",
                  prefixIcon: Icon(Icons.email_rounded),
                  border: OutlineInputBorder(),
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
            Center(child: Text("Confirm password")),
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
            Center(child: Text("Country")),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width - 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey)
              ),
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  Icon(Icons.contact_mail, color: Colors.grey,),
                  SizedBox(width: 10,),
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        onChanged: (value) {},
                        isExpanded: true,
                        value: "sadf",
                        items: [
                          DropdownMenuItem(child: Text("hi"),value: "sadf",),
                          DropdownMenuItem(child: Text("asdas"), value: "xc"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
                width: 100,
                child: ElevatedButton(onPressed: () {}, child: Text("Register"))),
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
