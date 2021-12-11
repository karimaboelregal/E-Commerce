import 'package:flutter/material.dart';
import 'product.dart';

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




