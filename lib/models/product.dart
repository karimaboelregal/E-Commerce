import 'package:flutter/material.dart';

class Product{
  final int id;
  final String title, description;
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
  });

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'title':title,
      'desc':description,
      //'size':size,
      'price':price,
      'images':images,
      //'colors':colors,


    };
  }

  factory Product.fromJson(Map<dynamic, dynamic> json) {
    List<Color> cols = [];
    List<String> s = [];
    if (json["colors"] != null) {
      for (String color in json['colors']) {
        cols.add(Color(hexToInt(color)));
      }
    }
    if (json["size"] != null) {
      for (String size in json["size"]) {
        s.add(size);
      }
    }
    return Product(
      id: json['id'],
      title: json['Name'],
      description: json['desc'],
      images: json['images'],
      size: s,
      colors: cols,
      price: json['price'].toDouble(),
      rating: json['rating'].toDouble(),
      isFavourite: true,
      isCart: false,
      isPopular: true,
    );
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
