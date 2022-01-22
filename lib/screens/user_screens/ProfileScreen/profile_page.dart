import 'dart:async';
import 'dart:convert';

import 'package:e_commerce1/models/user.dart';
import 'package:e_commerce1/services/auth_service.dart';
import 'package:e_commerce1/services/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import 'display_image_widget.dart';
import 'edit_description.dart';
import 'edit_email.dart';
import 'edit_image.dart';
import 'edit_name.dart';
import 'edit_phone.dart';

// This class handles the Page to dispaly the user's info on the "Edit Profile" Screen
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: context.read<ProfileProvider>().userInfo(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              userD data = snapshot.data! as userD;
              //print(data.name);
              return ListView(
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    toolbarHeight: 10,
                  ),
                  Center(
                      child: Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text(
                            'Profile',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(64, 105, 225, 1),
                            ),
                          ))),
                  InkWell(
                      onTap: () {
                        navigateSecondPage(EditImagePage());
                      },
                      child: DisplayImage(
                        imagePath: "sdf",
                        onPressed: () {},
                      )),
                  Center(
                      child: buildUserInfoDisplay(
                          data.name, 'Name', EditNameFormPage())),
                  Center(
                      child: buildUserInfoDisplay(
                          data.phone, 'Phone', EditPhoneFormPage())),
                  Center(
                      child: buildUserInfoDisplay(
                          data.email, 'Email', EditEmailFormPage())),
                  Center(child: buildAbout(data.about)),
                ],
              );
            } else {
              return Center(child: const CircularProgressIndicator());
            }
          }),
    );
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
      Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                  width: 350,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child: TextButton(
                                onPressed: () {
                                  if (title != "Email") {navigateSecondPage(editPage);}
                                },
                                child: Text(
                                  getValue,
                                  style: TextStyle(
                                      fontSize: 16,
                                      height: 1.4,
                                      color: Colors.black),
                                ))),
                        if(title!="Email")Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.grey,
                          size: 40.0,
                        )
                      ]))
            ],
          ));

  // Widget builds the About Me Section
  Widget buildAbout(String about) => Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tell Us About Yourself',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 1),
          Container(
              width: 350,
              height: 100,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              ))),
              child: Row(children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          navigateSecondPage(EditDescriptionFormPage());
                        },
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  about,
                                  style: TextStyle(
                                    fontSize: 16,
                                    height: 1.4,
                                  ),
                                ))))),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                  size: 40.0,
                )
              ]))
        ],
      ));

  // Refrshes the Page after updating user info.
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  // Handles navigation and prompts refresh.
  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}
