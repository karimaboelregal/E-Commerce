import 'package:e_commerce1/screens/user_screens/more_screens/login.dart';
import 'package:e_commerce1/screens/user_screens/navigation_bar.dart';
import 'package:e_commerce1/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/cart.dart';
import 'screens/user_screens/cart/cart_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Cart(),
        ),

      ],
      child : MaterialApp(
        routes: {
          "Navigation": (context) => Navigationbar(),
          "/login": (context) => Login(),
          "/cart":(context)=>CartScreen(),
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      )

    );

  }
}

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, "Navigation");
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xff0088ff),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_basket,
            size: 65.0,
            color: Colors.white,
          ),
          Text(
            "Ecommerce",
            style: TextStyle(color: Colors.white, fontSize: 35.0),
          ),
          CircularProgressIndicator(
            color: Colors.white,
          )
        ],
      )),
    );
  }
}
