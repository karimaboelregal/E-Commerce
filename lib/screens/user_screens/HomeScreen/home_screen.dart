import 'package:e_commerce1/screens/user_screens/cart/cart_screen.dart';
import 'package:e_commerce1/screens/user_screens/notifications/notifications_screen.dart';
import 'package:e_commerce1/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import 'Components/popular_products.dart';
import 'Components/discount_banner.dart';
import 'Components/categories.dart';
import 'package:e_commerce1/size_config.dart';

import 'Components/offers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
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
        body: SingleChildScrollView(
          child: Column(
              children: [SizedBox(height: getProportionateScreenWidth(20)),DiscountBanner(),Categories(),SpecialOffers(), SizedBox(height: getProportionateScreenWidth(20)),PopularProducts(),SizedBox(height: getProportionateScreenWidth(20))],
          ),
        )
    );
  }

}

