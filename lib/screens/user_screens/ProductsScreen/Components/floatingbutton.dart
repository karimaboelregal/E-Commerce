import 'package:e_commerce1/models/product.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce1/providers/cart_provider.dart';
FloatingActionButton floatingButton(Product product,Cart cart, bool issignedin, BuildContext context) {

  return FloatingActionButton(
    onPressed: () {
      if (!issignedin) {
        Navigator.pushNamed(context, "/login");
        return;
      }
      if(product.isCart == true)
      {
        cart.del(product.id);
        product.isCart = false;
      }
      else
      {
        //adds product object and the quantity which is one
        //print(widget.cart.productsSelected.containsKey(widget.product.id));
        cart.add(product, 1);
        product.isCart = true;
        //print(widget.cart.productsSelected.containsKey(widget.product.id));
      }

    },
    backgroundColor: Color(0xff0088ff),
    child: Icon(Icons.shopping_basket,
        color: Colors.white),
  );
}