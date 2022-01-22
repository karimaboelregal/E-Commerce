import 'dart:convert';

import 'package:e_commerce1/models/product.dart';
import 'package:e_commerce1/models/category.dart';
import 'package:e_commerce1/screens/user_screens/categories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);
  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  final database = FirebaseDatabase.instance; //database reference object
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
      Products.add(Product.fromJson(valueMap));
    }
    return Products;
  }
  Future AddProduct({required String name,required String type,required String desc,required String price,required String path}) async{
    List<String> imgs = [path];
    int price_int =int.parse(price);
    database.ref().child("Products").push().set({
      "Name": "" + name,
      "Type": "" + type,
      "desc": "" + desc,
      "price": price_int,
      "images": [path],
      "id": 1,
      "rating": 3,
    }).then((_) {
    });
  }
  Future<List<Category>> getAllCategories() async {
    var data = await database.ref("Categories").once();



    List<Category> Cat = [];
    for (var element in data.snapshot.children) {
      Map valueMap = json.decode(jsonEncode(element.value));
      String img = await storage.ref('categories/' + valueMap["image"]).getDownloadURL();
      valueMap["image"] = img;
      Cat.add(Category.fromJson(valueMap));
    }

    return Cat;
  }
  Future<String?> signUp(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("uid", _firebaseAuth.currentUser!.uid);
      prefs.setBool("isLoggedIn", true);
      prefs.setString("Email", email);

      return "Signed in";
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return e.message;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
