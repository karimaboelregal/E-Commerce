import 'package:e_commerce1/screens/user_screens/cart/cart_screen.dart';
import 'package:e_commerce1/screens/user_screens/notifications/notifications_screen.dart';
import 'package:flutter/material.dart';

import 'Components/product_list_widget.dart';

class ProductsScreen extends StatefulWidget {
  String? search;
  ProductsScreen({this.search});
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  TextEditingController searchText = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                  Navigator.pushNamed(context, "/profile");
                },
              ),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  width: 200,
                  child: TextField(
                    controller: searchText,
                    onSubmitted: (v) {
                      Navigator.pushNamed(context, "/Products", arguments: v);
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
        ],
      ),
      body: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 10, right: 10),
          child: ProductListWidget(search: widget.search,)),
    );
  }
}
