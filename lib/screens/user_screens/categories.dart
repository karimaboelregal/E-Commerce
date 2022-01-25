import 'package:e_commerce1/models/args.dart';
import 'package:e_commerce1/services/profile.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce1/models/category.dart';
import 'package:provider/src/provider.dart';
import 'cart/cart_screen.dart';
import 'notifications/notifications_screen.dart';
import '../../services/auth_service.dart';


class Categories extends StatelessWidget {
  final categories = [
    {
      "categoryName": "Mobile",
      "categoryImage":
          "https://www.zdnet.com/a/img/resize/d8d1dd7e6aed73b3a74b956e049faf7be983ee69/2021/01/07/455aade3-9b8b-435c-927d-9d5a2891c08f/samsung-galaxy-s20-fe-best-phones-review.png?width=1200&height=900&fit=crop&auto=webp"
    },
    {
      "categoryName": "Food",
      "categoryImage":
          "https://image.shutterstock.com/image-photo/french-fries-laid-out-on-260nw-1934045147.jpg"
    },
    {
      "categoryName": " phones",
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
    bool isSignedin = context.read<ProfileProvider>().isLoggedin();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle_rounded),
            color: Color(0xff0088ff),
            onPressed: () {
              if (isSignedin) {
                Navigator.pushNamed(context, "/profile");
              } else {
                Navigator.pushNamed(context, "/login");
              }
            },
          ),
          Container(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              width: 200,
              child: TextField(
                  onSubmitted: (v) {
                    Navigator.pushNamed(context, "/Products", arguments: ScreenArguments(0,v));
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.all(8),
                      hintText: 'Type to search',
                      hintStyle: TextStyle(
                        color: Colors.black45,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      )))),
          IconButton(
            icon: Icon(Icons.notifications),
            color: Color(0xff0088ff),
            onPressed: () {
              if (isSignedin) {
                Navigator.pushNamed(context, NotificationScreen.routeName);
              } else {
                Navigator.pushNamed(context, "/login");
              }
            },
          ),
          IconButton(
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
        ],
      ),
      body: FutureBuilder
        (
       future: context.read<AuthenticationService>().getAllCategories() ,
        builder: (context,snapshot)  {
    if (snapshot.hasData) {

      List<Category>? categories = snapshot.data as List<Category>?;


          return SingleChildScrollView
            (
            child: Column(
              children: [
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
                SizedBox(height: 20,),
                Container(
                  height: 400,
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 20,
                        crossAxisCount: 2,
                      ),
                      itemCount: categories?.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return Card(
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, "/Products", arguments: ScreenArguments(1,categories![index].title));
                            },
                            child: Column(
                              children: [
                                Image.network(
                                  categories![index].images,
                                  height: 120,
                                  width: 250,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(categories[index].title),
                              ],
                            ),
                          ),
                        );
                      }),
                ),

              ],
            ),
          );
        }
    return const Center(child: CircularProgressIndicator());
       }
      ),

    );
  }
}
