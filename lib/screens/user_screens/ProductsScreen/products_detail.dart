
import 'package:e_commerce1/models/product.dart';
import 'package:e_commerce1/services/profile.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'Components/details_widget.dart';
import 'Components/extensions.dart';
import './Components/product_details_components.dart';
import 'Components/floatingbutton.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce1/providers/cart_provider.dart';
import 'package:badges/badges.dart';

import 'package:e_commerce1/screens/user_screens/cart/cart_screen.dart';

class ProductDetailPage extends StatefulWidget {

  final Product product;
  ProductDetailPage({required this.product});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>{

  bool isLiked = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: true);
    bool isSignedin = context.read<ProfileProvider>().isLoggedin();
    return Scaffold(
      floatingActionButton: floatingButton(widget.product,cart,isSignedin, context),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xfffbfbfb),
                  Color(0xfff7f7f7),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  _appBar(),
                  productImage(widget.product.images),
                ],
              ),
              detailWidget(widget.product)
            ],
          ),
        ),
      ),
    );
  }


  Widget _appBar() {
    final cart = Provider.of<Cart>(context, listen: true);
    bool isSignedin = context.read<ProfileProvider>().isLoggedin();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
            size: 15,
            padding: 12,
            isOutLine: true,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),

          Badge(
            toAnimate: false,
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              color: Color(0xff0088ff),
              onPressed: () {
                if (isSignedin) {
                  Navigator.pushNamed(context, CartScreen.routeName);
                } else {
                  Navigator.pushNamed(context, "/login");
                }
              },
            ),
            badgeColor: kPrimaryColor,
            badgeContent: Text('${cart.getAmount()}', style: TextStyle(color: Colors.white)),
          ),
          _icon(isLiked ? Icons.favorite : Icons.favorite_border,
              color: isLiked ? Color(0xffF72804) : Color(0xffE1E2E4),
              size: 15,
              padding: 12,
              isOutLine: false, onPressed: () {
                setState(() {
                  isLiked = !isLiked;
                });
              }),
        ],
      ),
    );
  }

  Widget _icon(IconData icon, {Color color = const Color(0xffa8a09b), double size = 20, double padding = 10, bool isOutLine = false, required Function onPressed,}) {
    return Container(
      height: 40,
      width: 40,
      padding: EdgeInsets.all(padding),
      // margin: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border.all(
            color: Color(0xffa8a09b),
            style: isOutLine ? BorderStyle.solid : BorderStyle.none),
        borderRadius: BorderRadius.all(Radius.circular(13)),
        color:
        isOutLine ? Colors.transparent : Theme.of(context).backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Color(0xfff8f8f8),
              blurRadius: 5,
              spreadRadius: 10,
              offset: Offset(5, 5)),
        ],
      ),
      child: Icon(icon, color: color, size: size),
    ).ripple(() {
      if (onPressed != null) {
        onPressed();
      }
    }, borderRadius: BorderRadius.all(Radius.circular(13)));
  }



}