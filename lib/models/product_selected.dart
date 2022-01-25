import 'dart:convert';

import 'package:flutter/material.dart';
import 'product.dart';




class ProductSelected{
  final Product product;
  int numOfItem;
  ProductSelected({required this.product, required this.numOfItem});

  Map<String, dynamic> toMap(){
    return {
      'product${product.id}':product.toMap()
       ,'qty':numOfItem
    };
  }

}
// Demo data for our cart
List<ProductSelected> dummyCarts = [
  ProductSelected(product: dummyProducts[0], numOfItem: 2),
  ProductSelected(product: dummyProducts[1], numOfItem: 1),
  ProductSelected(product: dummyProducts[3], numOfItem: 1),
];




