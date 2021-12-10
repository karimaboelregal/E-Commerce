import 'package:flutter/material.dart';

import 'product.dart';

class Notifications {
  final Product product;
  final int numOfItem;

  Notifications({required this.product, required this.numOfItem});
}


List<Notifications> dummyNotifications = [
  Notifications(product: dummyProducts[1], numOfItem: 2),
  Notifications(product: dummyProducts[2], numOfItem: 1),
  Notifications(product: dummyProducts[0], numOfItem: 1),
];
