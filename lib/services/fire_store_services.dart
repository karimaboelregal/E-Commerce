import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreServices {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference coins = FirebaseFirestore.instance.collection('user');

  Future<Object?> addCoin(String id, double amount) async {
    try {
      DocumentReference documentReference =
          coins.doc(uid).collection("Coins").doc(id);
      FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(documentReference);
        if (!snapshot.exists) {
          documentReference.set({"Amount": amount});
        }
        double newAmount = snapshot["Amount"] + amount;
        transaction.update(documentReference, {"Amount": newAmount});
      });
    } catch (e) {
      return e;
    }
  }

  // Future<List> getCoins() async {
  //   List<Coin> asd = [];
  //   coins.doc(uid).collection("Coins").get();
  //   return asd;
  // }

  Future<void> removeCoin(String id) async {
    coins.doc(uid).collection("Coins").doc(id).delete();
  }
}
