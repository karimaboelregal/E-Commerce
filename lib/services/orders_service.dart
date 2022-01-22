
import 'dart:async';

import 'package:e_commerce1/models/orders.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/utils/stream_subscriber_mixin.dart';

class OrdersService{
  final database = FirebaseDatabase.instance.ref("Orders");
  Map<dynamic,dynamic> data = {};

  late StreamSubscription<DatabaseEvent> orderStream;
  OrdersService();


  
  Future save({required Map<String,dynamic> order,required String userId}) async{

    database.child(userId)
        .push()
        .set(order)
        .then((_) => print('order placed'))
        .catchError((error)=> print('you got an error $error'));
  }

  Map<dynamic,dynamic> listenToOrders(String Id)  {
    orderStream = database.child(Id).onValue.listen((event) {
      data = event.snapshot.value as Map<dynamic,dynamic>;
    });
    return data;
    //return data;
  }


}