import 'package:flutter/material.dart';

import 'Components/popular_products.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PopularProducts());
  }

}

