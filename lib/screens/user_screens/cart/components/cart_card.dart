import 'package:e_commerce1/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce1/models/product_selected.dart';
import 'package:e_commerce1/size_config.dart';
import 'package:e_commerce1/constants.dart';
import 'package:provider/provider.dart';

class CartCard extends StatelessWidget {
  CartCard({
    Key? key,
    required this.cart,
    required this.index
  }) : super(key: key);

  ProductSelected cart;
  int index;
  @override
  Widget build(BuildContext context) {
    final cartProv = Provider.of<Cart>(context,listen: true);
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(cart.product.images[0]),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cart.product.title,
              style: TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: "\$${cart.product.price}",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
                children: [
                  TextSpan(
                      text: " x${cart.numOfItem}",
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            )
          ],
        ),
        SizedBox(width:getProportionateScreenWidth(10))
        ,
        Padding(
          padding: EdgeInsets.only(bottom:getProportionateScreenWidth(10)),
          child:Row(children: [
            IconButton(icon: Icon(Icons.remove), color: Color(0xff0088ff), onPressed: () {
              //cartProv.productsSelected[index]!.numOfItem -= 1;
              cart.numOfItem -= 1;
              cartProv.decrease_quantity(index);
            },),
            Text("${cart.numOfItem}"),
            IconButton(icon: Icon(Icons.add), color: Color(0xff0088ff), onPressed: () {
              //cartProv.productsSelected[index]!.numOfItem += 1;
              cart.numOfItem += 1;
              cartProv.increase_quantity(index);
            },),
          ],),

        )

      ],
    );
  }
}
