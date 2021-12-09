import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          WillPopScope(
              onWillPop: () {
                globals.currentTab.value = 3;
                return Future.value(false);
              },
              child: Text('')),
          Center(child: Text("login")),
        ],
      ),
    );
  }
}
