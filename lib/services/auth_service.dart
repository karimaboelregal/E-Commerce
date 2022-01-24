import 'dart:convert';

import 'package:e_commerce1/models/product.dart';
import 'package:e_commerce1/models/category.dart';
import 'package:e_commerce1/screens/user_screens/HomeScreen/Components/popular_products.dart';
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


  Future AddCategory({required String name,required String desc,required String path}) async{
    String imgs = path;
    print(path);
    if(path==null||path==''){
      imgs="noimg.jfif";
    }
    database.ref().child("Categories").push().set({
      "name": "" + name,
      "Desc": "" + desc,
      "image": imgs,

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
      {required String email, required String password, required String name}) async {
    try {
      var result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      result.user!.updateDisplayName(name);
      database.ref().child("users").push().set({
        "uid": ""+result.user!.uid,
        "Address": "",
        "Type": "user",
        "about": "",
        "phone": "",
        "notifications": [{"title": "Welcome to this app", "body": "Welcome to our e commerce app"}]
      }).then((_) {
      });

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
      _firebaseAuth.setPersistence(Persistence.SESSION);
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