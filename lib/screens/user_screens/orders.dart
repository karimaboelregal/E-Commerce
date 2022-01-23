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
                    try{
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
                    }catch(e){
                      return CircularProgressIndicator();

                    }
                    if(value.orders.first.orderId != null){



                    }
                    else{
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


