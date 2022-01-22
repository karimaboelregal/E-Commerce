import 'package:e_commerce1/models/orders.dart';
import 'package:firebase_database/firebase_database.dart';

class OrdersService{
  final database = FirebaseDatabase.instance.ref("Orders");

  OrdersService();

  Future save({required Map<String,dynamic> order,required String userId}) async{

    database.child(userId)
        .push()
        .set(order)
        .then((_) => print('order placed'))
        .catchError((error)=> print('you got an error $error'));
  }


}