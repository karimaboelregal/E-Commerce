import 'package:flutter/material.dart';

import '../globals.dart' as globals;

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 80),
          Center(child: Text("register")),
          WillPopScope(
              onWillPop: () {
                globals.currentTab.value = 3;
                return Future.value(false);
              },
              child: Text('')),
        ],
      ),
    );
  }
}
