import 'package:flutter/material.dart';

class Category {

  final String title, description;
  final List<String> images;



  Category({
    required this.description,
    required this.images,
    required this.title,

  });

  factory Category.fromJson(Map<dynamic, dynamic> json) {

    return Category(

      title: json['Name'],
      description: json['desc'],
      images: json['images'],

    );
  }
}

//dummy cat
List<Category> dummyProducts = [
  Category(

    images: [
      "assets/images/gibsonGuitar.png",
    ],
    title: "mobile phones",
    description: description,

  ),
  Category(

    images: [
      "assets/images/gibsonGuitar.png",
    ],

    title: "cat2",

    description: description,

  ),
  Category(

    images: [
      "assets/images/gibsonGuitar.png",
    ],

    title: "cat3",
    description: description,
  ),
  Category(

      images: [
        "assets/images/gibsonGuitar.png",
      ],
      title: "cat4",
      description: description,
  )
  ];

const String description =
    "desc";
