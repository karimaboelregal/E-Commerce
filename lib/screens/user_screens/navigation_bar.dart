import 'package:e_commerce1/screens/user_screens/orders.dart';
import 'package:e_commerce1/screens/user_screens/products.dart';
import 'package:flutter/material.dart';
import 'HomeScreen/HomeScreen.dart';
import 'categories.dart';
import 'more.dart';
import 'more_screens/Register.dart';
import 'more_screens/contact_us.dart';
import 'more_screens/login.dart';
import 'more_screens/products.dart';
import 'globals.dart' as globals;

import 'cart/cart_screen.dart';

class Navigationbar extends StatefulWidget {
  @override
  State<Navigationbar> createState() => aNavigationBar();
}

class aNavigationBar extends State<Navigationbar> {

  final List<Widget> _pages = [
    HomeScreen(),
    ProductsScreen(),
    Categories(),
    MoreScreen(),
    Login(),
    Register(),
    Orders()
  ];
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: globals.currentTab,
      builder: (BuildContext context, value, Widget? child) {
        return Scaffold(
          appBar: (globals.currentTab.value >= 3)? null:AppBar(backgroundColor: Colors.transparent,elevation: 0,automaticallyImplyLeading: false,actions: [
            IconButton(icon: Icon(Icons.account_circle_rounded), color: Color(0xff0088ff), onPressed: () {},),
            Container (padding: EdgeInsets.symmetric(vertical: 12.0),width: 230,child: TextField(decoration: InputDecoration(prefixIcon: Icon(Icons.search),border: OutlineInputBorder( borderSide: BorderSide(color: Colors.blueAccent,),borderRadius: BorderRadius.circular(5.0),), isDense: true,contentPadding: EdgeInsets.all(8),   hintText: 'Type to search',hintStyle: TextStyle(color: Colors.black45,fontSize: 12,fontStyle: FontStyle.italic,)))),
            IconButton(icon: Icon(Icons.notifications), color: Color(0xff0088ff), onPressed: () {},),
            IconButton(icon: Icon(Icons.shopping_cart), color: Color(0xff0088ff), onPressed: () {Navigator.pushNamed(context, CartScreen.routeName);},),
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
