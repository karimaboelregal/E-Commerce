import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  final categories = [
    {
      "categoryName": "Mobile phones",
      "categoryImage":
          "https://www.zdnet.com/a/img/resize/d8d1dd7e6aed73b3a74b956e049faf7be983ee69/2021/01/07/455aade3-9b8b-435c-927d-9d5a2891c08f/samsung-galaxy-s20-fe-best-phones-review.png?width=1200&height=900&fit=crop&auto=webp"
    },
    {
      "categoryName": "Food",
      "categoryImage":
          "https://image.shutterstock.com/image-photo/french-fries-laid-out-on-260nw-1934045147.jpg"
    },
    {
      "categoryName": "Mobile phones",
      "categoryImage":
          "https://www.zdnet.com/a/img/resize/d8d1dd7e6aed73b3a74b956e049faf7be983ee69/2021/01/07/455aade3-9b8b-435c-927d-9d5a2891c08f/samsung-galaxy-s20-fe-best-phones-review.png?width=1200&height=900&fit=crop&auto=webp"
    },
    {
      "categoryName": "Food",
      "categoryImage":
          "https://image.shutterstock.com/image-photo/french-fries-laid-out-on-260nw-1934045147.jpg"
    },
    {
      "categoryName": "Mobile phones",
      "categoryImage":
          "https://www.zdnet.com/a/img/resize/d8d1dd7e6aed73b3a74b956e049faf7be983ee69/2021/01/07/455aade3-9b8b-435c-927d-9d5a2891c08f/samsung-galaxy-s20-fe-best-phones-review.png?width=1200&height=900&fit=crop&auto=webp"
    },
    {
      "categoryName": "Food",
      "categoryImage":
          "https://image.shutterstock.com/image-photo/french-fries-laid-out-on-260nw-1934045147.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 30,),
        Center(child: Column(children: [
          Icon(
            Icons.shopping_basket,
            size: 65.0,
            color: Color(0xff0088ff),
          ),
          Text(
            "Ecommerce",
            style: TextStyle(color: Color(0xff0088ff), fontSize: 35.0),
          ),

        ],)),
        SizedBox(height: 50,),
        Container(
          height: 400,
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                crossAxisSpacing: 20,
              ),
              itemCount: categories.length,
              itemBuilder: (BuildContext ctx, index) {
                return Card(

                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Image.network(
                          categories[index]["categoryImage"]!,
                          height: 150,
                          width: 250,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(categories[index]["categoryName"]!),
                      ],
                    ),
                  ),
                );
              }),
        ),

      ],
    );
  }
}
