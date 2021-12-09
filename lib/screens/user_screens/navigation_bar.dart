import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'categories.dart';
import 'more.dart';
import 'more_screens/Register.dart';
import 'more_screens/login.dart';
import 'globals.dart' as globals;

class NavigationBar extends StatefulWidget {
  @override
  State<NavigationBar> createState() => aNavigationBar();
}

class aNavigationBar extends State<NavigationBar> {

  final List<Widget> _pages = [
    HomeScreen(),
    HomeScreen(),
    Categories(),
    MoreScreen(),
    Login(),
    Register()
  ];
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: globals.currentTab,
      builder: (BuildContext context, value, Widget? child) {
        return Scaffold(
          appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,automaticallyImplyLeading: false,actions: [
            IconButton(icon: Icon(Icons.notifications), color: Color(0xff0088ff), onPressed: () {},),
            IconButton(icon: Icon(Icons.shopping_cart), color: Color(0xff0088ff), onPressed: () {},),
            SizedBox(width: 10,)
          ],),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Color(0xff0088ff),
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.white,
            backgroundColor: Colors.black,
            currentIndex: (globals.currentTab.value > 3)? 3:globals.currentTab.value,
            onTap: (index) {
              setState(() {
                globals.currentTab.value = index;
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
          body: _pages[globals.currentTab.value],
        );
      }
    );
  }
}
