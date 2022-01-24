import 'package:e_commerce1/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce1/models/product.dart';
//import 'package:e_commerce1/models/product_selected.dart';
import 'package:e_commerce1/providers/cart_provider.dart';
import 'package:e_commerce1/size_config.dart';
import 'package:e_commerce1/constants.dart';
import 'package:provider/provider.dart';
class PopularProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: true);

    return Column(
      children: [

        Row(
          children: [
            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
              child:
              Text('Best Products',
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
          child: FutureBuilder(
              future: context.read<AuthenticationService>().PopularProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Product>? products = snapshot.data as List<Product>?;
                  return Row(
                    children: [
                      ...List.generate(
                        products!.length,
                            (index) {
                            return ProductCard(product: products[index],cart:cart);
                            // here by default width and height is 0
                        },
                      ),
                      SizedBox(width: getProportionateScreenWidth(20)),
                    ],
                  );
                }
                return const Center(child: CircularProgressIndicator());
              }
          ),
        )
      ],
    );
  }
}


class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
    required this.cart,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;
  final Cart cart;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
            context,
            "/singeProduct", arguments: product
        );
      },
      child: Padding(
        padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
        child: SizedBox(
          width: getProportionateScreenWidth(width),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1.02,
                  child: Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                    decoration: BoxDecoration(
                      //leave it at 0.0 for now la7ad matgeeb swar ndeefa mafhash background
                      color: kSecondaryColor.withOpacity(0.0),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Hero(
                      tag: product.id.toString(),
                      child: Image.network(product.images[0]),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  product.title,
                  style: TextStyle(color: Colors.black),
                  maxLines: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${product.price}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: kPrimaryColor,
                      ),
                    ),
                    CartButton(product:product,cart:cart)
                  ],
                )
              ],
            ),
          ),

      ),
    );
  }
}


class CartButton extends StatefulWidget
{

  const CartButton({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
    required this.cart,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;
  final Cart cart;


  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {

  void _toggleCart(){
    setState(() {
      if(widget.product.isCart == true)
      {
        widget.cart.del(widget.product.id);
        widget.product.isCart = false;
      }
      else
      {
        //adds product object and the quantity which is one
        //print(widget.cart.productsSelected.containsKey(widget.product.id));
        widget.cart.add(widget.product, 1);
        widget.product.isCart = true;
        //print(widget.cart.productsSelected.containsKey(widget.product.id));
      }
    });


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: _toggleCart,
      child: Container(
          padding: EdgeInsets.all(getProportionateScreenWidth(0)),
          height: getProportionateScreenWidth(30),
          width: getProportionateScreenWidth(30),
          decoration: BoxDecoration(
            color: widget.cart.productsSelected.containsKey(widget.product.id)
                ? kPrimaryColor.withOpacity(0.3)
                : kSecondaryColor.withOpacity(0.09),
            shape: BoxShape.circle,
          ),
          child:Icon(
            Icons.shopping_cart,
            color: kPrimaryColor,
          )
      ),

    );
  }
}



