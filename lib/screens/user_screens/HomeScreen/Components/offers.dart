import 'package:e_commerce1/models/args.dart';
import 'package:e_commerce1/models/category.dart';
import 'package:e_commerce1/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce1/size_config.dart';
import 'package:provider/src/provider.dart';


class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.read<AuthenticationService>().getAllCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Category> allCats = snapshot.data as List<Category>;
            return Column(
                children: [
            Row(
            children: [
            Padding(
            padding:
                EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
          child:
          Text('Best Offers',
          style: TextStyle(
          fontSize: getProportionateScreenWidth(18),
          color: Colors.black,
          )
          ),
          ),
          ],
          ),
          SizedBox(height: getProportionateScreenWidth(20)),
          SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(

          children: List.generate(
          allCats.length,

          (index) => SpecialOfferCard(
          image: allCats[index].images,
          category: allCats[index].title,
          numOfBrands: 18,
          press: () {},
          ),
          )))]);
          } else {
          return Center(child: CircularProgressIndicator(),);
          }
        }
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/Products", arguments: ScreenArguments(1,category));
        },
        child: SizedBox(
          width: getProportionateScreenWidth(242),
          height: getProportionateScreenWidth(100),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF343434).withOpacity(0.4),
                        Color(0xFF343434).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15.0),
                    vertical: getProportionateScreenWidth(10),
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: "$numOfBrands Brands")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
