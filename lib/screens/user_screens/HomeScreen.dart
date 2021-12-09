import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,actions: [
          Icon(Icons.shopping_cart, color: Colors.red,)
        ],),
        body: Center(child: Text("Home screen")));
  }

}

