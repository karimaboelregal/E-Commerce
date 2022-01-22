import 'package:e_commerce1/models/product.dart';
import 'package:flutter/material.dart';
import './product_details_components.dart';

Widget detailWidget(Product ProductDetails) {
  return DraggableScrollableSheet(
    maxChildSize: .8,
    initialChildSize: .53,
    minChildSize: .53,
    builder: (context, scrollController) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10).copyWith(bottom: 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            color: Colors.white),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(height: 5),
              Container(
                alignment: Alignment.center,
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Color(0xffa8a09b),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(ProductDetails.title,style: TextStyle(fontSize: 25),),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("\$ ",style: TextStyle(fontSize: 18,color: Color(0xffF72804)),),
                            Text(ProductDetails.price.toString(),style: TextStyle(fontSize: 25),),
                          ],
                        ),
                        Row(
                          children:List.generate(5,(index){
                            if (index+1 <= ProductDetails.rating) {
                              return Icon(Icons.star,
                                  color: Color(0xfffbba01), size: 17);
                            } else {
                              return Icon(Icons.star, size: 17);
                            }
                          })

                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              if(ProductDetails.size.length>0)availableSize(ProductDetails.size),
              SizedBox(
                height: 20,
              ),
              if(ProductDetails.colors.length>0)availableColor(ProductDetails.colors),
              SizedBox(
                height: 20,
              ),
              descriptionWidget(ProductDetails.description),
            ],
          ),
        ),
      );
    },
  );
}