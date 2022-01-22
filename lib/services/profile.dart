import 'dart:convert';

import 'package:e_commerce1/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _database = FirebaseDatabase.instance;
  userD? US;


  bool isLoggedin() {
    if (_firebaseAuth.currentUser == null) {
      return false;
    }
    return true;
  }

  Future<userD> userInfo() async {
    if (_firebaseAuth.currentUser != null) {
      var about = await _database.ref().child("users")
          .orderByChild("uid")
          .equalTo(_firebaseAuth.currentUser!.uid)
          .once();
      Map valueMap = json.decode(jsonEncode(about.snapshot.value));
      String? name = getName();
      String? email = getEmail();
      valueMap[valueMap.keys.first]['name'] = name == null ? "" : name;
      valueMap[valueMap.keys.first]['email'] = email == null ? "" : email;
      US = userD.fromJson(valueMap[valueMap.keys.first], valueMap.keys.first);
      return US!;
    }
    return US!;
  }

  String? getName() {
    if (_firebaseAuth.currentUser != null) {
      return _firebaseAuth.currentUser!.displayName;
    }
    return "";
  }

  Future<bool> updateName(String name) async {
    if (_firebaseAuth.currentUser != null) {
      US!.name = name;
      await _firebaseAuth.currentUser!.updateDisplayName(name);
      notifyListeners();
      return true;
    }
    return true;
  }

  Future<bool> updatePhone(String phone) async {
    if (_firebaseAuth.currentUser != null) {
      await _database.ref("users/"+US!.key+"/phone").set(phone);
      US!.phone = phone;
      notifyListeners();
      return true;
    }
    return true;
  }

  Future<bool> updateAbout(String about) async {
    if (_firebaseAuth.currentUser != null) {
      await _database.ref("users/"+US!.key+"/about").set(about);
      US!.about = about;
      notifyListeners();
      return true;
    }
    return true;
  }

  String? getUID() {
    if (_firebaseAuth.currentUser != null) {
      return _firebaseAuth.currentUser!.uid;
    }
    return "";
  }

  String? getEmail() {
    if (_firebaseAuth.currentUser != null) {
      return _firebaseAuth.currentUser!.email;
    }
    return "";
  }

}