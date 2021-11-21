import 'package:flutter/material.dart';

import 'HomeScreen.dart';
import 'categories.dart';
import 'more.dart';

class NavigationBar extends StatefulWidget {
  @override
  State<NavigationBar> createState() => _NavigationBar();
}

class _NavigationBar extends State<NavigationBar> {
  int _selectedIndex = 0; //New

  final List<Widget> _pages = [
    HomeScreen(),
    HomeScreen(),
    Categories(),
    MoreScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xff0088ff),
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
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
      body: _pages[_selectedIndex],
    );
  }
}
