import 'package:e_commerce1/screens/user_screens/orders.dart';
import 'package:flutter/material.dart';

import 'HomeScreen/HomeScreen.dart';
import 'ProductsScreen/products.dart';
import 'cart/cart_screen.dart';
import 'categories.dart';
import 'globals.dart' as globals;
import 'more.dart';
import 'more_screens/Register.dart';
import 'more_screens/contact_us.dart';
import 'more_screens/login.dart';
import 'notifications/notifications_screen.dart';

class Navigationbar extends StatefulWidget {
  @override
  State<Navigationbar> createState() => aNavigationBar();
}

class aNavigationBar extends State<Navigationbar> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  List currentPages = [];
  int currentTab = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    ProductsScreen(),
    Categories(),
    MoreScreen(),
    Login(),
    Register(),
    Orders(),
    Contact()
  ];

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
      body: WillPopScope(
        onWillPop: () async {
          if (_navigatorKey.currentState!.canPop()) {
            currentPages.removeLast();
            _navigatorKey.currentState!.pop();
            if (currentPages.last == "home") {
              setState(() {
                currentTab = 0;
              });
            } else if (currentPages.last == "prod") {
              setState(() {
                currentTab = 1;
              });
            } else if (currentPages.last == "cate") {
              setState(() {
                currentTab = 2;
              });
            } else if (currentPages.last == "more") {
              setState(() {
                currentTab = 3;
              });
            }

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
                if (currentTab!=0) {
                  setState(() {
                    currentTab = 0;
                  });
                }
                builder = (BuildContext context) => HomeScreen();
                currentPages.add("home");
                break;
              case '/login':
                setState(() {
                  currentTab = 3;
                });
                builder = (BuildContext context) => Login();
                currentPages.add("more");
                break;
              case '/more':
                setState(() {
                  currentTab = 3;
                });
                builder = (BuildContext context) => MoreScreen();
                currentPages.add("more");
                break;
              case '/Register':
                setState(() {
                  currentTab = 3;
                });
                builder = (BuildContext context) => Register();
                currentPages.add("more");
                break;
              case '/Products':
                setState(() {
                  currentTab = 1;
                });
                builder = (BuildContext context) => ProductsScreen();
                currentPages.add("prod");
                break;
              case '/Categories':
                setState(() {
                  currentTab = 2;
                });
                builder = (BuildContext context) => Categories();
                currentPages.add("cate");
                break;
              case '/cart':
                builder = (BuildContext context) => CartScreen();
                break;
              case '/notification':
                builder = (BuildContext context) => NotificationScreen();
                break;
              case '/contact':
                setState(() {
                  currentTab = 3;
                });
                builder = (BuildContext context) => Contact();
                currentPages.add("more");
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
      ),
    );
  }
}
