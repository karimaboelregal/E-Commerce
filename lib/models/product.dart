import 'dart:convert';

import 'package:flutter/material.dart';

class Product{
  final int id;
  final String title, description, type;
  final List<String> images;
  final List<Color> colors;
  final double rating, price;
  final List<String> size;
  bool isFavourite, isPopular, isCart;

  Product({
    required this.id,
    required this.images,
    required this.colors,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    this.isCart = false,
    required this.title,
    required this.size,
    required this.price,
    required this.description,
    required this.type,
  });

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'title':title,
      'desc':description,
      //'size':size,
      'Type':type,
      'price':price,
      'images':images,
      //'colors':colors,


    };
  }

  factory Product.fromJson(Map<dynamic, dynamic> json,int option) {

    List<Color> cols = [];
    List<String> s = [];

    if (json["colors"] != null) {
      for (String color in json['colors']) {
        //cols.add(Color(hexToInt(color)));
      }
    }
    if (json["sizes"] != null) {
      for (String size in json["sizes"]) {
        s.add(size);
      }
    }
    //perform abo el regal logic
    if(option == 1){
      return Product(
        id: json['id'],
        title: json['Name'],
        description: json['desc'],
        images: json['images'],
        size: s,
        type: json['Type'],
        colors: cols,
        price: json['price'].toDouble(),
        rating: json['rating'].toDouble(),
        isFavourite: true,
        isCart: false,
        isPopular: true,
      );
    }
    //performs adel logic
    else{
      List<dynamic> images = jsonDecode(jsonEncode(json['images']));
      var stringImages = List<String>.from(images);
      return Product(id: json['id'],
          images: stringImages,
          colors: cols,
          title: json['title'],
          type: json['Type'],
          size: s,
          price: json['price'].toDouble(),
          description: json['desc']);
    }
  }
}

int hexToInt(String hex) {
  int val = 0;
  int len = hex.length;
  for (int i = 0; i < len; i++) {
    int hexDigit = hex.codeUnitAt(i);
    if (hexDigit >= 48 && hexDigit <= 57) {
      val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
    } else if (hexDigit >= 65 && hexDigit <= 70) {
      // A..F
      val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
    } else if (hexDigit >= 97 && hexDigit <= 102) {
      // a..f
      val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
    } else {
      throw new FormatException("Invalid hexadecimal value");
    }
  }
  return val;
}

//dummy Products
List<Product> dummyProducts = [
  Product(
    id: 1,
    images: [
      "assets/images/gibsonGuitar.png",
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    size: ["M"],
    title: "Gibson Guitar™",
    type: "asdf",
    price: 64.99,
    description: description,
    rating: 4.8,
    isFavourite: true,
    isCart: false,
    isPopular: true,
  ),
  Product(
    id: 2,
    images: [
      "assets/images/gibsonGuitar.png",
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    type: "asdf",
    size: ["M"],
    title: "Blues guitar not a thing",
    price: 50.5,
    description: description,
    rating: 4.1,
    isPopular: true,
    isCart: false,
  ),
  Product(
    id: 3,
    images: [
      "assets/images/gibsonGuitar.png",
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    type: "asdf",
    size: ["M"],
    title: "guitar of all guitars",
    price: 36.55,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isCart: false,
    isPopular: true,
  ),
  Product(
      id: 4,
      images: [
        "assets/images/gibsonGuitar.png",
      ],
      size: ["M"],
      colors: [
        const Color(0xFFF6625E),
        const Color(0xFF836DB8),
        const Color(0xFFDECB9C),
        Colors.white,
      ],
      type: "asdf",
      title: "another guitar",
      price: 20.20,
      description: description,
      rating: 4.1,
      isFavourite: true,
      isCart: false,
      isPopular: true),
];

const String description =
    "One of the most expensive guitars with the purest sound you would ever hear";
