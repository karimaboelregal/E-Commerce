import 'package:flutter/material.dart';


class Address {
  String street;
  String country;
  String administrativeArea;
  //String SubadministrativeArea;
  double lat;
  double long;
  Address(this.street, this.country, this.administrativeArea,
      this.lat, this.long);

  @override
  String toString() {
    return 'Address: $street, $administrativeArea,$country';
  }
}