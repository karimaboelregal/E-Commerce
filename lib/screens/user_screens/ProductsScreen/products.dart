import 'package:e_commerce1/models/args.dart';
import 'package:e_commerce1/screens/user_screens/cart/cart_screen.dart';
import 'package:e_commerce1/screens/user_screens/notifications/notifications_screen.dart';
import 'package:e_commerce1/services/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import 'Components/product_list_widget.dart';

class ProductsScreen extends StatefulWidget {
  String? search;
  String? cat;
  ProductsScreen({this.search, this.cat});
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  TextEditingController searchText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool isSignedin = context.read<ProfileProvider>().isLoggedin();
    if (widget.search != null) {
      searchText.text = widget.search!;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.account_circle_rounded),
                color: Color(0xff0088ff),
                onPressed: () {
                  if (isSignedin) {
                    Navigator.pushNamed(context, "/profile");
                  } else {
                    Navigator.pushNamed(context, "/login");
                  }
                },
              ),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  width: 200,
                  child: TextField(
                    controller: searchText,
                    onSubmitted: (v) {
                      Navigator.pushNamed(context, "/Products", arguments: ScreenArguments(0,v));
                    },
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
                  if (isSignedin) {
                    Navigator.pushNamed(context, NotificationScreen.routeName);
                  } else {
                    Navigator.pushNamed(context, "/login");
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.shopping_cart),
                color: Color(0xff0088ff),
                onPressed: () {
                  if (isSignedin) {
                    Navigator.pushNamed(context, CartScreen.routeName);
                  } else {
                    Navigator.pushNamed(context, "/login");
                  }
                },
              ),

            ],
          ),
        ],
      ),
      body: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 10, right: 10),
          child: ProductListWidget(search: widget.search,cat:widget.cat)),
    );
  }
}
