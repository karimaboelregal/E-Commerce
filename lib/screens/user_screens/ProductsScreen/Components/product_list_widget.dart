import 'package:e_commerce1/services/auth_service.dart';
import 'package:e_commerce1/services/fire_store_services.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce1/models/product.dart';
import 'package:e_commerce1/screens/user_screens/ProductsScreen/products_detail.dart';
import 'package:provider/src/provider.dart';

class ProductListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.read<AuthenticationService>().getAllProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product>? products = snapshot.data as List<Product>?;
            return GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(1.0),
              childAspectRatio: 8.0 / 12.0,
              children: [
                ...List.generate(
                  products!.length, (index) {
                  if (products[index].isPopular)
                    return GridTile(
                        child: GridTilesProducts(product: products[index],));

                  return SizedBox
                      .shrink(); // here by default width and height is 0
                },
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        }
    );
  }
}

class GridTilesProducts extends StatelessWidget {
  const GridTilesProducts({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetailPage(product: product,)),
        );
      },
      child: Container(
        padding: EdgeInsets.only(top: 5),
        child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            elevation: 0,
            child: Center(
              child: Column(
                children: <Widget>[
                  Image.network(
                    product.images[0],
                    width: 150,
                    height: 150,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 10, right: 10, top: 15),
                    child: Text(
                        (product.title.length <= 40 ? product.title : product.title.substring(0, 40)),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color(0xFF444444),
                            fontFamily: 'Roboto-Light.ttf',
                            fontSize: 15,
                            fontWeight: FontWeight.w400)),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Text("৳  ${(product.price != null) ? product.price : 'Unavailable'}",
                        style: TextStyle(
                            color: (product.price != null)
                                ? Color(0xff2890c8)
                                : Colors.red,
                            fontFamily: 'Roboto-Light.ttf',
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                  )
                ],
              ),
            )),
      ),
    );
  }
}