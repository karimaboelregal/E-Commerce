import 'package:flutter/material.dart';

class Category {

  final String title, description;
  final String images;



  Category({
    required this.description,
    required this.images,
    required this.title,

  });

  factory Category.fromJson(Map<dynamic, dynamic> json) {

    return Category(

      title: json['name'],
      description: json['Desc'],
      images: json['image'],

    );
  }
}


