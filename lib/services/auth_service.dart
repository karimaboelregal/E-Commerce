import 'dart:convert';

import 'package:e_commerce1/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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
      valueMap['image'] = await storage.ref('products/'+valueMap['image']).getDownloadURL();
      Products.add(Product.fromJson(valueMap));
    }
    return Products;
  }

  void AddProduct() async{
    database.ref().child("Products").push().set({
      "Name": "" + "Test product",
      "Type": "" + "testing",
      "desc": "" + "decription",
      "id": "" + "123",
      "rating": "" + "1",
      "price": "" + "123",
    }).then((_) {
      print('product added.');
    });
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
