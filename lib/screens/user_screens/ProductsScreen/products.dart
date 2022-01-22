import 'package:e_commerce1/screens/user_screens/cart/cart_screen.dart';
import 'package:e_commerce1/screens/user_screens/notifications/notifications_screen.dart';
import 'package:flutter/material.dart';

import 'Components/product_list_widget.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle_rounded),
            color: Color(0xff0088ff),
            onPressed: () {
              Navigator.pushNamed(context, "/profile");
            },
          ),
          Container(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              width: 200,
              child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.all(8),
                      hintText: 'Type to search',
                      hintStyle: TextStyle(
                        color: Colors.black45,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      )))),
          IconButton(
            icon: Icon(Icons.notifications),
            color: Color(0xff0088ff),
            onPressed: () {
              Navigator.pushNamed(context, NotificationScreen.routeName);
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Color(0xff0088ff),
            onPressed: () {
              Navigator.pushNamed(context, CartScreen.routeName);
            },
          ),
        ],
      ),
      body: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 10, right: 10),
          child: ProductListWidget()),
    );
  }
}
