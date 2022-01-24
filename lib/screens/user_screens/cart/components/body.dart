import 'package:e_commerce1/services/profile.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce1/providers/cart_provider.dart';
import 'package:e_commerce1/size_config.dart';
import 'cart_card.dart';
import 'package:provider/provider.dart';

class CartVal extends StatelessWidget{

  const CartVal({
    Key? key,
    required this.valText,
  }) : super(key: key);

  final String valText;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(child:
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          valText,
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        Image.asset(
          "assets/images/empty-cart.gif",
          fit: BoxFit.cover,
        )
      ],)

    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final profile = Provider.of<ProfileProvider>(context, listen:true);
    if(profile.isLoggedin()){
      if(cart.productsSelected.isNotEmpty){
        return Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: ListView.builder(
            itemCount: cart.productsSelected.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Dismissible(
                key: Key(cart.productsSelected.values.elementAt(index).product.id.toString()),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
                    cart.productsSelected.values.elementAt(index).product.isCart = false;
                    cart.del(cart.productsSelected.values.elementAt(index).product.id);

                  });
                },
                background: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFE6E6),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Spacer(),
                    ],
                  ),
                ),
                child: CartCard(cart: cart.productsSelected.values.elementAt(index)),
              ),
            ),


          ),
        );
      }
      else{
        return CartVal(valText: "Add products before checking out :)");
      }
    }
    else{
      return CartVal(valText: "you need to log in before placing orders :)",);
    }

  }


}


