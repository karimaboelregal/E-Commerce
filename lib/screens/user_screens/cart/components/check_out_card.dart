import 'dart:convert';

import 'package:e_commerce1/models/orders.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce1/size_config.dart';
import 'package:e_commerce1/constants.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce1/providers/cart_provider.dart';


class CheckoutCard extends StatelessWidget {

  const CheckoutCard({
    Key? key,
    required this.cartScreenContext,
  }) : super(key: key);
  final BuildContext cartScreenContext;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: true);


    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: getProportionateScreenWidth(40),
                  width: getProportionateScreenWidth(40),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: null//svg pic here,
                ),
                Spacer(),
                Text("Add voucher code"),
                const SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kTextColor,
                )
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text.rich(
                  TextSpan(
                    text: "Total:\n",
                    children: [
                      TextSpan(
                        text: "\$${cart.getTotalPrice()}",
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: ElevatedButton(onPressed: () {

                    //Map<String, dynamic> jsontest = {'id':1,'price':20};



                    showMyDialogSuccess(context,cartScreenContext,cart);

                  },
                      child: Text("Check Out"))
                ),
              ],
            ),
          ],
        ),
      ),
    );


  }

  Future<void> showToast(BuildContext context) async{
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('OrderPlaced: check your orders :)'),
        action: SnackBarAction(label: 'Hide', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  Future<void> showMyDialogSuccess(BuildContext context,BuildContext cartScreenContext,final cart) async {
    //final cart = Provider.of<Cart>(context, listen: true);

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Place Order ?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure you would like to place orders'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Order order = Order(cart.toMap());
                order.save();

                showToast(context);
                cart.deleteAll();
                print(cart.productsSelected);
                Navigator.of(context).pop();
                Navigator.of(cartScreenContext).pop();

                //clearText();
              },
            ),
          ],
        );
      },
    );
  }



}


