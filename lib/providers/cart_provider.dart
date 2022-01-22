import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:e_commerce1/models/product.dart';
import 'package:e_commerce1/models/product_selected.dart';


class Cart extends ChangeNotifier{
  Map<int,ProductSelected> productsSelected = {};
  late double totalPrice = 0;


  Map<String, dynamic> toMap(){
    var results = productsSelected.values.map((element)=>element.toMap()).toList();
    //print(results);

    //print(Map<dynamic,dynamic>.fromIterable(results));

    return {
      'ProductsOrdered':results,
      'totalPrice':totalPrice
    };
  }


  add(Product product, int numOfItem) {
    productsSelected.putIfAbsent(product.id,()=>ProductSelected(product : product,numOfItem : numOfItem));
    notifyListeners();
  }

  del(int id) {
    productsSelected.remove(id);
    notifyListeners();
  }

  //returns the number of items in the cart
  int getAmount() {
    return productsSelected.length;
  }


  @override
  String toString() {
    return 'Cart{productsSelected: $productsSelected}';
  }
}