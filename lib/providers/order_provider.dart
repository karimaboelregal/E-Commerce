import 'dart:async';

import 'package:e_commerce1/models/orders.dart';
import 'package:e_commerce1/models/product.dart';
import 'package:e_commerce1/models/product_selected.dart';
import 'package:e_commerce1/services/orders_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class orderProvider extends ChangeNotifier{
  final OrdersService _ordersService = OrdersService();
  late List<Order> _orders;
  final database = FirebaseDatabase.instance.ref("Orders");
  late StreamSubscription<DatabaseEvent> orderStream;

  List<Order> get orders => _orders!;

  orderProvider(){
    listenToOrders();
  }


  void listenToOrders() async {
    //print('listenting');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //validate if not logged in
    String userId = prefs.getString("uid")!;
    //String userId = "6S6pWxmUDxMMc05NzppE27OToqT2";
    Map<dynamic,dynamic> data =  _ordersService.listenToOrders(userId);
    //print(data);
    orderStream = database.child(userId).onValue.listen((event) {
      data = event.snapshot.value as Map<dynamic,dynamic>;
      _orders = data.entries.map((e) => Order.fromRTDB(e.key, e.value, userId)).toList();
      //print(_orders.first.userId);
      notifyListeners();

    });

    //print(_orders);
    //if(orders.isNotEmpty)
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print('disposed');
    orderStream.cancel();
    super.dispose();
  }






}