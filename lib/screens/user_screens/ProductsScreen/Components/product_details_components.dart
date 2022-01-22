import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce1/screens/user_screens/ProductsScreen/Components/extensions.dart';
import 'package:flutter/material.dart';

Widget productImage(productImage) {

  return Container(
      alignment: Alignment.topCenter,
      child: CarouselSlider(
          options: CarouselOptions(viewportFraction:1),
          items: productImage.map<Widget>((item) => Container(
                    child: Center(

                        child: Image.network(item,
                            fit: BoxFit.cover, width: 1000, height: 220,)),
                  ))
              .toList()));
}

class availableSize extends StatefulWidget {
  List<String> sizes;

  availableSize(this.sizes);

  @override
  State<availableSize> createState() => _availableSizeState();
}

class _availableSizeState extends State<availableSize> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Available Size",
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 20),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: widget.sizes.map((name) {
              var index = widget.sizes.indexOf(name);

              return Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(0xffa8a09b),
                      style: selected == index
                          ? BorderStyle.none
                          : BorderStyle.solid),
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                  color:
                      selected == index ? Color(0xffE65829) : Color(0xffa8a09b),
                ),
                child: Text(
                  name,
                  style: TextStyle(
                      fontSize: 16,
                      color: selected == index
                          ? Color(0XFFFFFFFF)
                          : const Color(0xff1d2635)),
                ),
              ).ripple(() {
                setState(() {
                  selected = index;
                });
              }, borderRadius: BorderRadius.all(Radius.circular(13)));
            }).toList())
      ],
    );
  }
}

class availableColor extends StatefulWidget {
  List<Color> colors;

  availableColor(this.colors);

  @override
  State<availableColor> createState() => _availableColorState();
}

class _availableColorState extends State<availableColor> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Available Color",
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 20),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: widget.colors.map((name) {
              var index = widget.colors.indexOf(name);

              return InkWell(
                onTap: () {
                  setState(() {
                    selected = index;
                  });
                },
                child: CircleAvatar(
                  radius: selected == index ? 14 : 10,
                  backgroundColor: name.withAlpha(255),
                  child: selected == index
                      ? Icon(
                          Icons.check_circle,
                          color: Colors.white,
                          size: 18,
                        )
                      : CircleAvatar(radius: 7, backgroundColor: Colors.white),
                ),
              );
            }).toList())
      ],
    );
  }
}

Widget descriptionWidget(String desc) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        "Description",
        style: TextStyle(fontSize: 14),
      ),
      SizedBox(height: 20),
      Text(desc),
    ],
  );
}

Widget _colorWidget(Color color, {bool isSelected = false}) {
  return CircleAvatar(
    radius: isSelected ? 14 : 10,
    backgroundColor: color.withAlpha(255),
    child: isSelected
        ? Icon(
            Icons.check_circle,
            color: Colors.white,
            size: 18,
          )
        : CircleAvatar(radius: 7, backgroundColor: Colors.white),
  );
}
