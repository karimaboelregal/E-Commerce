import 'dart:convert';

import 'package:e_commerce1/models/args.dart';
import 'package:e_commerce1/providers/order_provider.dart';
import 'package:e_commerce1/screens/user_screens/orders.dart';
import 'package:e_commerce1/services/profile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import 'HomeScreen/home_screen.dart';
import 'ProductsScreen/products.dart';
import '../../models/product.dart';
import 'ProductsScreen/products_detail.dart';
import 'ProfileScreen/profile_page.dart';
import 'cart/cart_screen.dart';
import 'categories.dart';
import 'maps_screen.dart';
import 'more.dart';
import 'more_screens/Register.dart';
import 'more_screens/addproduct_screen.dart';
import 'more_screens/addcategory_screen.dart';
import 'more_screens/contact_us.dart';
import 'more_screens/login.dart';
import 'more_screens/makeadmins_screen.dart';
import 'notifications/notifications_screen.dart';

class Navigationbar extends StatefulWidget {
  @override
  State<Navigationbar> createState() => aNavigationBar();
}

class aNavigationBar extends State<Navigationbar> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  int currentTab = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    ProductsScreen(),
    Categories(),
    MoreScreen(),
    Login(),
    Register(),
    //Orders(),
    ChangeNotifierProvider<orderProvider>(create:(_)=>orderProvider(),child: Orders()),
    Contact()
  ];

  AndroidNotificationChannel channel = AndroidNotificationChannel(
    'my_channel', // id
    'My Channel', // title
    description: 'Important notifications from my server.', // description
    importance: Importance.high,
  );
  Future asyncFunction() async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    var initializeAndroidSettings = AndroidInitializationSettings('mipmap/ic_launcher');
    var settings = InitializationSettings(android: initializeAndroidSettings);

    flutterLocalNotificationsPlugin.initialize(settings);
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

    await context.read<ProfileProvider>().userInfo();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      print("hi 1");
      if (notification != null && android != null) {
        print("hi 2");
        context.read<ProfileProvider>().addNotif(notification.title, notification.body);
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

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xff0088ff),
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.black,
        currentIndex: currentTab,
        onTap: (index) {
          setState(() {
            if (index != currentTab) {
              currentTab = index;
              if (index == 0) {
                _navigatorKey.currentState!.pushNamed('/');
              } else if (index == 1) {
                _navigatorKey.currentState!.pushNamed('/Products');
              } else if (index == 2) {
                _navigatorKey.currentState!.pushNamed('/Categories');
              } else if (index == 3) {
                _navigatorKey.currentState!.pushNamed('/more');
              }
            }
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more),
            label: 'More',
          ),
        ],
      ),
      body: FutureBuilder(
        future: asyncFunction(),
        builder: (context, snapshot) {
          return WillPopScope(
            onWillPop: () async {
              if (_navigatorKey.currentState!.canPop()) {
                bool f = false;
                _navigatorKey.currentState!.popUntil((route) {
                  if (f == false) {
                    f = true;
                    return false;
                  }
                  if (route.settings.name == "/") {
                    setState(() {
                      currentTab = 0;
                    });
                  } else if (route.settings.name == "/Products") {
                    setState(() {
                      currentTab = 1;
                    });
                  } else if (route.settings.name == "/Categories") {
                    setState(() {
                      currentTab = 2;
                    });
                  } else if (route.settings.name == "/cart" || route.settings.name == "/notifications" || route.settings.name == "/maps") {

                  } else if (route.settings.name =='/singeProduct') {
                    setState(() {
                      currentTab = 1;
                    });
                  } else {
                    setState(() {
                      currentTab = 3;
                    });
                  }
                  return true;
                });
                return false;
              }
              return true;
            },
            child: Navigator(
              key: _navigatorKey,
              initialRoute: '/',
              onGenerateRoute: (RouteSettings settings) {
                WidgetBuilder builder;
                // Manage your route names here
                switch (settings.name) {
                  case '/':
                    if (currentTab != 0) {
                      setState(() {
                        currentTab = 0;
                      });
                    }
                    builder = (BuildContext context) => HomeScreen();
                    break;
                  case '/login':
                    setState(() {
                      currentTab = 3;
                    });
                    builder = (BuildContext context) => Login();
                    break;
                  case "/profile":
                    builder = (BuildContext context) => ProfilePage();
                    break;
                  case '/more':
                    setState(() {
                      currentTab = 3;
                    });
                    builder = (BuildContext context) => MoreScreen();
                    break;
                  case '/Register':
                    setState(() {
                      currentTab = 3;
                    });
                    builder = (BuildContext context) => Register();
                    break;
                  case '/Products':
                    setState(() {
                      currentTab = 1;
                    });
                    if (settings.arguments != null) {

                      ScreenArguments args = settings.arguments as ScreenArguments;

                      if (args.type == 0) {
                        builder = (BuildContext context) =>
                            ProductsScreen(
                                search: args.text);
                      } else {
                        builder = (BuildContext context) =>
                            ProductsScreen(cat: args.text);
                      }
                    } else {
                      builder = (BuildContext context) =>
                          ProductsScreen();
                    }
                    break;
                  case '/Categories':
                    setState(() {
                      currentTab = 2;
                    });
                    builder = (BuildContext context) => Categories();
                    break;
                  case '/cart':
                    builder = (BuildContext context) => CartScreen();
                    break;
                  case '/notification':
                    builder = (BuildContext context) => NotificationScreen();
                    break;
                  case '/maps':
                    builder = (BuildContext context) => Maps();
                    break;
                  case '/addproduct_screen':
                    builder = (BuildContext context) => AddProduct();
                    break;
                  case '/addadmins_screen':
                    builder = (BuildContext context) => MakeAdmins();
                    break;
                  case '/addcategory_screen':
                    builder = (BuildContext context) => AddCategory();
                    break;
                  case '/contact':
                    setState(() {
                      currentTab = 3;
                    });
                    builder = (BuildContext context) => Contact();
                    break;
                  case '/orders':
                    setState(() {
                      currentTab = 3;
                    });
                    builder = (BuildContext context) => ChangeNotifierProvider<orderProvider>(
                        create:(_)=>orderProvider(),
                        child: Orders());
                    break;
                  case '/singeProduct':
                    setState(() {
                      currentTab = 1;
                    });
                    builder = (BuildContext context) => ProductDetailPage(product: settings.arguments as Product,);
                    break;
                  default:
                    throw Exception('Invalid route: ${settings.name}');
                }
                // You can also return a PageRouteBuilder and
                // define custom transitions between pages
                return MaterialPageRoute(
                  builder: builder,
                  settings: settings,
                );
              },
            ),
          );
        }
      ),
    );
  }
}
