import 'package:flutter/material.dart';





class Product{
  final int id;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating, price;
  bool isFavourite, isPopular,isCart;

  Product({
    required this.id,
    required this.images,
    required this.colors,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    this.isCart = false,
    required this.title,
    required this.price,
    required this.description,
  });
  factory Product.fromJson(Map<dynamic, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['Name'],
      description: json['desc'],
      images: [json['image']],
      colors: [      const Color(0xFFF6625E),
        const Color(0xFF836DB8),
        const Color(0xFFDECB9C),
        Colors.white,
      ],
      price: json['price'].toDouble(),
      rating: 4.8,
      isFavourite: true,
      isCart:false,
      isPopular: true,
    );
  }
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
    title: "Gibson Guitar™",
    price: 64.99,
    description: description,
    rating: 4.8,
    isFavourite: true,
    isCart:false,
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
    title: "Blues guitar not a thing",
    price: 50.5,
    description: description,
    rating: 4.1,
    isPopular: true,
    isCart:false,
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
    title: "guitar of all guitars",
    price: 36.55,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isCart:false,
    isPopular: true,
  ),
  Product(
    id: 4,
    images: [
      "assets/images/gibsonGuitar.png",
    ],
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
    isCart:false,
    isPopular:true
  ),
];

const String description =
    "One of the most expensive guitars with the purest sound you would ever hear";
