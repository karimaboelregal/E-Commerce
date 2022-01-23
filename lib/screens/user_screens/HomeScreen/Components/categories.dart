import 'package:e_commerce1/constants.dart';
import 'package:e_commerce1/models/category.dart';
import 'package:e_commerce1/services/auth_service.dart';
import 'package:e_commerce1/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';


class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<IconData> categories_icons = [Icons.assignment_sharp,Icons.attach_money,Icons.videogame_asset,Icons.card_giftcard];
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: FutureBuilder(
          future: context.read<AuthenticationService>().getAllCategories(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Category>? categories = snapshot.data as List<Category>?;

            return Row(

              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                categories!.length,

                    (index) => CategoryCard(
                  icon: (categories_icons..shuffle()).first,
                  text: categories[index].title,
                  press: () {},
                ),
              ),
            );
          }



            return const Center(child: CircularProgressIndicator());
          }
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final IconData? icon;
  final String? text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: kPrimaryColor,
                size: getProportionateScreenHeight(40),
              ),
            ),
            SizedBox(height: 5),
            Text(text!, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
