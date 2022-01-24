import 'package:e_commerce1/models/address.dart';
import 'package:flutter/material.dart';


class addressNotifier extends ChangeNotifier{
  Address? address;
  //addressNotifier();

  updateAddress(String street,String country,String administrativeArea,
      double lat,double long){
    address = Address(street,country,"test",lat,long);
    notifyListeners();

  }


}