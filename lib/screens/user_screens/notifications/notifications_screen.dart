import 'package:e_commerce1/services/profile.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce1/models/notification.dart';
import 'package:provider/src/provider.dart';

import 'components/body.dart';


class NotificationScreen extends StatefulWidget {
  static String routeName = "/notification";

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),

    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Notifications",
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
