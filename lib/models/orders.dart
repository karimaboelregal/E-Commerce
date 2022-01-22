import 'package:e_commerce1/services/orders_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Order{
  Map<String, dynamic> cartItems;
  final OrdersService _ordersService = OrdersService();


  Order(this.cartItems);

  save() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //validate if not logged in
    String userId = prefs.getString("uid")!;
    /*
    Map<String,dynamic> order = {
      userId:userId,
      'order':cartItems
    };*/
    await _ordersService.save(order: cartItems,userId:userId);
  }

}