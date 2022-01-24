import 'package:flutter/material.dart';
import 'package:e_commerce1/models/notification.dart';
import 'package:e_commerce1/size_config.dart';
import 'package:e_commerce1/constants.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
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
              child: Icon(Icons.notifications),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            Container(
              width: 200,
              child: Text(
                body,
                style: TextStyle(color: Colors.black, fontSize: 16),
                maxLines: 2,
              ),
            ),



          ],
        ),
        SizedBox(width:getProportionateScreenWidth(10))
        ,
        Padding(
          padding: EdgeInsets.only(bottom:getProportionateScreenWidth(10)),
          child:IconButton(icon: Icon(Icons.arrow_back_sharp), color: Color(0xff0088ff), onPressed: () {},),
        )

      ],
    );
  }
}
