import 'package:flutter/material.dart';
import 'package:e_commerce1/models/cart.dart';
import 'package:e_commerce1/size_config.dart';
import 'cart_card.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.builder(
        itemCount: cart.productsSelected.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key(cart.productsSelected.values.elementAt(index).product.id.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                cart.productsSelected.values.elementAt(index).product.isCart = false;
                cart.del(cart.productsSelected.values.elementAt(index).product.id);

              });
            },
            background: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Spacer(),
                ],
              ),
            ),
            child: CartCard(cart: cart.productsSelected.values.elementAt(index)),
          ),
        ),
      ),
    );
  }
}
