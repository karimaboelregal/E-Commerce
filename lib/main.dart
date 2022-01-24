import 'package:e_commerce1/screens/user_screens/more_screens/login.dart';
import 'package:e_commerce1/screens/user_screens/navigation_bar.dart';
import 'package:e_commerce1/services/auth_service.dart';
import 'package:e_commerce1/services/profile.dart';
import 'package:e_commerce1/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce1/providers/cart_provider.dart';

import 'screens/user_screens/cart/cart_screen.dart';
import 'screens/user_screens/notifications//notifications_screen.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  AndroidNotificationChannel channel = AndroidNotificationChannel(
    'my_channel', // id
    'My Channel', // title
    description: 'Important notifications from my server.', // description
    importance: Importance.high,
  );
  Future asyncFunction() async {
    final FBAPP = await Firebase.initializeApp();
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("here notif ");
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: android.smallIcon,
              ),
            ));
      }
    });

    return FBAPP;
  }

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
            create: (context) => ProfileProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'E-commerce',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: FutureBuilder(
              future: asyncFunction(),
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
