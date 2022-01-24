import 'dart:convert';

import 'package:e_commerce1/models/product.dart';
import 'package:e_commerce1/models/category.dart';
import 'package:e_commerce1/screens/user_screens/HomeScreen/Components/popular_products.dart';
import 'package:e_commerce1/screens/user_screens/categories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Products with ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final database = FirebaseDatabase.instance;
  final storage = firebase_storage.FirebaseStorage.instance;

  Future<List<Product>> getAllProducts() async {
    var data = await database.ref("Products").once();

    List<Product> Products = [];
    for (var element in data.snapshot.children) {
      Map valueMap = json.decode(jsonEncode(element.value));
      List<String> imgs = [];
      for (String image in valueMap['images']) {
        String img = await storage.ref('products/' + image).getDownloadURL();
        imgs.add(img);
      }
      valueMap["images"] = imgs;
      Products.add(Product.fromJson(valueMap,1));
    }
    return Products;
  }

  Future<List<Product>> PopularProducts() async {
    var data = await database.ref("Products").once();

    List<Product> Products = [];
    for (var element in data.snapshot.children) {
      Map valueMap = json.decode(jsonEncode(element.value));
      if (valueMap['rating']> 3){
        List<String> imgs = [];
        for (String image in valueMap['images']) {
          String img = await storage.ref('products/' + image).getDownloadURL();
          imgs.add(img);
        }
        valueMap["images"] = imgs;
        Products.add(Product.fromJson(valueMap,1));
      }
    }
    return Products;
  }

  Future<List<Product>> getAllProductsByid(catid) async {
    print("ahmedddddd");
    print(catid);

    var data = await database.ref("Products").once();

    List<Product> Products = [];
    for (var element in data.snapshot.children) {
      Map valueMap = json.decode(jsonEncode(element.value));
      if (valueMap['Type'] == catid){
        List<String> imgs = [];
        for (String image in valueMap['images']) {
          String img = await storage.ref('products/' + image).getDownloadURL();
          imgs.add(img);
        }
        valueMap["images"] = imgs;
        Products.add(Product.fromJson(valueMap,1));
      }
      else if (catid == null){
        List<String> imgs = [];
        for (String image in valueMap['images']) {
          String img = await storage.ref('products/' + image).getDownloadURL();
          imgs.add(img);
        }
        valueMap["images"] = imgs;
        Products.add(Product.fromJson(valueMap,1));
      }
    }
    return Products;
  }

  Future AddProduct({required String name,required String? type,required String desc,required String price,required String path}) async{
    List<String> imgs = [path];
    int price_int =int.parse(price);
    database.ref().child("Products").push().set({
      "Name": "" + name,
      "Type": "" + type!,
      "desc": "" + desc,
      "price": price_int,
      "images": [path],
      "id": 1,
      "rating": 5,
    }).then((_) {
    });
  }

}