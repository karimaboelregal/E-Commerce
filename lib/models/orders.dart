import 'package:e_commerce1/models/product.dart';
import 'package:e_commerce1/models/product_selected.dart';
import 'package:e_commerce1/services/orders_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Order{
  Map<String, dynamic> cartItems = {};
  final OrdersService _ordersService = OrdersService();
  String? userId;
  String? totalPrice;
  String? orderId;
  ProductSelected? productsOrdered;


  Order({required this.userId,required this.totalPrice,required this.orderId,required this.productsOrdered});

  Order.fromMap(this.cartItems);

  factory Order.fromRTDB(String key,Map<dynamic,dynamic> value,String userId){
    late ProductSelected productOrdered;
    //print(value);
    String orderId = key;
    //print(key);
    Map<dynamic,dynamic> orderJson = value;
    String totalPrice = orderJson['totalPrice'].toString();
    //print(orderJson['ProductsOrdered']);
    var productsOrderedJson = orderJson['ProductsOrdered'] as List<dynamic>;
    //List<ProductSelected> productsOrdered = [];
    productsOrderedJson.forEach((element) {
      var productOrderedJson = List.from(element.values);
      int quantity = productOrderedJson[0];
      Map<dynamic,dynamic> productJson = Map.from(productOrderedJson[1]);
      productOrdered = ProductSelected(product: Product.fromJson(productJson,2),numOfItem: quantity);
    });
    Order o = Order(
        userId: userId,
        totalPrice: totalPrice,
        productsOrdered: productOrdered,orderId: key);

    return o;

  }


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

