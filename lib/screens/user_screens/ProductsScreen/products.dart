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
      body: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 10, right: 10),
          child: ProductListWidget(
          )),
    );
  }
}


