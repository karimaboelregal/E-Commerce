import 'package:e_commerce1/providers/order_provider.dart';
import 'package:e_commerce1/screens/user_screens/more_screens/login.dart';
import 'package:e_commerce1/screens/user_screens/navigation_bar.dart';
import 'package:e_commerce1/services/auth_service.dart';
import 'package:e_commerce1/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce1/providers/cart_provider.dart';

import 'screens/user_screens/cart/cart_screen.dart';
import 'screens/user_screens/notifications//notifications_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FBAPP = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance),
          ),
          StreamProvider(
              create: (context) =>
              context
                  .read<AuthenticationService>()
                  .authStateChanges,
              initialData: null),
          ChangeNotifierProvider(
            create: (context) => Cart(),
          ),
          ChangeNotifierProvider(
              create:(context) => orderProvider(),
          )
        ],
        child: MaterialApp(
          title: 'E-commerce',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: FutureBuilder(
              future: FBAPP,
              builder: (context, _snapshot) {
                if (_snapshot.hasData) {
                  Future.delayed(Duration(seconds: 3), () {
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        Navigationbar()), (Route<dynamic> route) => false);
                  });
                  return actualScreen();
                } else if (_snapshot.hasError) {
                  print(_snapshot);
                  return Text("hi");
                } else {
                  return actualScreen();
                }
              }),
        ));
  }
}


class actualScreen extends StatelessWidget {

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
