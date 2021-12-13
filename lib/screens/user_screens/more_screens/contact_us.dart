import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
          child: Column(
          children: const [
            Icon(
            Icons.shopping_basket,
            size: 65.0,
            color: Color(0xff0088ff),
          ),
          Text(
            "Ecommerce",
            style: TextStyle(color: Color(0xff0088ff), fontSize: 35.0),
          ),
          ],
        )),
              ContactUs(
                textColor: Colors.white,
                cardColor: Color(0xff0088ff),
                companyColor: Color(0xFF223555),
                email: 'ahmed@gmail.com',
                taglineColor: Color(0xFF223555),
                dividerColor: Color(0xff0088ff),
                emailText: "Contact via email",
                companyName: '',
                phoneNumber: '01015660411',
                phoneNumberText: "Contact via number",
                website: 'https://www.ecommerce.com',
                websiteText: 'Visit website',
                facebookHandle: "httsps",
              ),
            ],
          ),
        ),
      ),
    );
  }
}