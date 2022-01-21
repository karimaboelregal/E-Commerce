import 'package:flutter/material.dart';
import 'package:e_commerce1/models/product_selected.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce1/providers/cart_provider.dart';


import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CheckoutCard(cartScreenContext: context),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: true);
    return AppBar(
      title: Column(
        children: [
          Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${cart.getAmount()} items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
