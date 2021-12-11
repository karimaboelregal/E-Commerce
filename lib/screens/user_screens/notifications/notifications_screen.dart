import 'package:flutter/material.dart';
import 'package:e_commerce1/models/notification.dart';

import 'components/body.dart';


class NotificationScreen extends StatelessWidget {
  static String routeName = "/notification";
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
          Text(
            "${dummyNotifications.length} items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
