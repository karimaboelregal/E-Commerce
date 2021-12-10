import 'package:flutter/material.dart';

import 'product.dart';

class Cart {
  final Product product;
  final int numOfItem;

  Cart({required this.product, required this.numOfItem});
}

// Demo data for our cart

List<Cart> dummyCarts = [
  Cart(product: dummyProducts[0], numOfItem: 2),
  Cart(product: dummyProducts[1], numOfItem: 1),
  Cart(product: dummyProducts[3], numOfItem: 1),
];
