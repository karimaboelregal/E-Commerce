import 'package:flutter/material.dart';
import 'product.dart';




class ProductSelected{
  final Product product;
  final int numOfItem;
  ProductSelected({required this.product, required this.numOfItem});
}
// Demo data for our cart
List<ProductSelected> dummyCarts = [
  ProductSelected(product: dummyProducts[0], numOfItem: 2),
  ProductSelected(product: dummyProducts[1], numOfItem: 1),
  ProductSelected(product: dummyProducts[3], numOfItem: 1),
];




