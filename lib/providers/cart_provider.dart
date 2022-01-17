import 'package:flutter/material.dart';
import 'package:e_commerce1/models/product.dart';
import 'package:e_commerce1/models/product_selected.dart';


class Cart extends ChangeNotifier{
  Map<int,ProductSelected> productsSelected = {};
  late double totalPrice;



  add(Product product, int numOfItem) {
    productsSelected.putIfAbsent(product.id,()=>ProductSelected(product : product,numOfItem : numOfItem));
    notifyListeners();
  }

  del(int id) {
    productsSelected.remove(id);
    notifyListeners();
  }

  @override
  String toString() {
    return 'Cart{productsSelected: $productsSelected}';
  }
}