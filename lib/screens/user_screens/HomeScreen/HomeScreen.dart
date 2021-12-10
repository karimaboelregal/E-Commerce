import 'package:flutter/material.dart';

import 'Components/popular_products.dart';
import 'Components/discount_banner.dart';
import 'Components/categories.dart';
import 'package:e_commerce1/size_config.dart';

import 'Components/offers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
              children: [SizedBox(height: getProportionateScreenWidth(20)),DiscountBanner(),Categories(),SpecialOffers(), SizedBox(height: getProportionateScreenWidth(20)),PopularProducts()],
          ),
        )
    );
  }

}

