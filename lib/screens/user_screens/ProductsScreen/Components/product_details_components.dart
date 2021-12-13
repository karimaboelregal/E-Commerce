import 'package:e_commerce1/models/product.dart';
import 'package:e_commerce1/screens/user_screens/ProductsScreen/Components/extensions.dart';
import 'package:flutter/material.dart';


Widget productImage(productImage) {


  return Container(
      alignment: Alignment.topCenter,
      child: Image.asset(productImage,
        width: 1000,
        height: 220,)
  );
}

Widget availableSize() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text("Available Size",
        style: TextStyle(fontSize: 14),
      ),
      SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _sizeWidget("US 6"),
          _sizeWidget("US 7", isSelected: true),
          _sizeWidget("US 8"),
          _sizeWidget("US 9"),
        ],
      )
    ],
  );
}

Widget availableColor() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text("Available Color",style: TextStyle(fontSize: 14),
      ),
      SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _colorWidget(Color(0xfffbba01), isSelected: true),
          SizedBox(
            width: 30,
          ),
          _colorWidget(Color(0xff5F5F60)),
          SizedBox(
            width: 30,
          ),
          _colorWidget(Color(0xff20262C)),
          SizedBox(
            width: 30,
          ),
          _colorWidget(Color(0xffF72804)),
          SizedBox(
            width: 30,
          ),
          _colorWidget(Color(0xff2890c8)),
        ],
      )
    ],
  );
}

Widget descriptionWidget() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text("Description",style: TextStyle(fontSize: 14),
      ),
      SizedBox(height: 20),
      Text("Clean lines, versatile and timeless—the people shoe returns with the Nike Air Max 90. Featuring the same iconic Waffle sole, stitched overlays and classic TPU accents you come to love, it lets you walk among the pantheon of Air. ßNothing as fly, nothing as comfortable, nothing as proven. The Nike Air Max 90 stays true to its OG running roots with the iconic Waffle sole, stitched overlays and classic TPU details. Classic colours celebrate your fresh look while Max Air cushioning adds comfort to the journey."),
    ],
  );
}

Widget _sizeWidget(String text, {bool isSelected = false}) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      border: Border.all(
          color: Color(0xffa8a09b),
          style: !isSelected ? BorderStyle.solid : BorderStyle.none),
      borderRadius: BorderRadius.all(Radius.circular(13)),
      color:
      isSelected ? Color(0xffE65829) : Color(0xffa8a09b),
    ),
    child: Text(text,style: TextStyle(fontSize: 16,color: isSelected ? Color(0XFFFFFFFF) : const Color(0xff1d2635)),
    ),
  ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13)));
}

Widget _colorWidget(Color color, {bool isSelected = false}) {
  return CircleAvatar(
    radius: 12,
    backgroundColor: color.withAlpha(150),
    child: isSelected
        ? Icon(
      Icons.check_circle,
      color: color,
      size: 18,
    )
        : CircleAvatar(radius: 7, backgroundColor: color),
  );
}




