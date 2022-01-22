import 'dart:convert';

import 'package:e_commerce1/models/orders.dart';
import 'package:e_commerce1/models/product_selected.dart';
import 'package:e_commerce1/providers/cart_provider.dart';
import 'package:e_commerce1/providers/order_provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'globals.dart' as globals;

class Orders extends StatelessWidget {
  final database = FirebaseDatabase.instance.ref("Orders");

  @override
  Widget build(BuildContext context) {
    //final orders = Provider.of<orderProvider>(context);
    //orders.listenToOrders();

    /*
    database.child('6S6pWxmUDxMMc05NzppE27OToqT2').onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic,dynamic>;
      //Map<String,dynamic> yourOrders = jsonDecode(jsonEncode(event.snapshot.value));
      print(data.keys);
    });
   */
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 80),
            Center(
                child: Column(
              children: const [
                Icon(
                  Icons.shopping_basket,
                  size: 65.0,
                  color: Color(0xff0088ff),
                ),
                Text(
                  "Ecommerce",
                  style: TextStyle(color: Color(0xff0088ff), fontSize: 35.0),
                ),
              ],
            )),
            WillPopScope(
                onWillPop: () {
                  print("hi");
                  globals.currentTab.value = 3;
                  return Future.value(false);
                },
                child: Text("")),
            Padding(
              padding: EdgeInsets.all(getProportionateScreenWidth(8.0)),
              child: Column(
                children: [
                  Text("your orders"),
                  Consumer<orderProvider>(builder: (context,value,child){
                  //value.listenToOrders();
                    //return Text("${value.orders.length}");
                    value.listenToOrders();
                    if(value.orders.isNotEmpty){

                      List<Order> orders = value.orders;
                      //print(orders[0].orderId);
                      //print(orders.first.orderId);
                      //print(orders.first.totalPrice);
                      //print(orders.first.productsOrdered!.numOfItem);
                      //print(orders.first.productsOrdered!.product);


                      //return Text("${value.orders.length}");



                         return SizedBox(
                          height:getProportionateScreenHeight(600),
                          child:ListView(
                            children: [
                              ...orders.map((e) => Card(
                                child: ListTile(
                                  title: Text(e.orderId!),
                                ),
                              ))
                            ],
                          ),
                        );

                    }
                    else{
                      return CircularProgressIndicator();
                    }

                  }


                  )

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

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
        child: SizedBox(
          height: getProportionateScreenHeight(600),
          child: ListView.builder(
            itemCount: cart.productsSelected.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Dismissible(
                key: Key(cart.productsSelected.values
                    .elementAt(index)
                    .product
                    .id
                    .toString()),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
                    cart.productsSelected.values
                        .elementAt(index)
                        .product
                        .isCart = false;
                    cart.del(cart.productsSelected.values
                        .elementAt(index)
                        .product
                        .id);
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
                child: CartCard(
                    cart: cart.productsSelected.values.elementAt(index)),
              ),
            ),
          ),
        ));
  }
}

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final ProductSelected cart;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset(cart.product.images[0]),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cart.product.title,
              style: TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: "\$${cart.product.price}",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
                children: [
                  TextSpan(
                      text: " x${cart.numOfItem}",
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            )
          ],
        ),
        SizedBox(width: getProportionateScreenWidth(10)),
        Padding(
          padding: EdgeInsets.only(bottom: getProportionateScreenWidth(10)),
          child: IconButton(
            icon: Icon(Icons.delete_forever),
            color: Color(0xff0088ff),
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
