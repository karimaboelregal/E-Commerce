import 'package:flutter/material.dart';

import 'globals.dart' as globals;

class Orders extends StatelessWidget {
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
