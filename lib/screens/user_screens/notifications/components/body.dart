import 'package:e_commerce1/services/profile.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce1/models/notification.dart';
import 'package:e_commerce1/size_config.dart';
import 'package:provider/src/provider.dart';
import 'notification_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<ProfileProvider>().getAllNotif(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List data = snapshot.data as List;
          return Padding(
            padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) =>
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Dismissible(
                      key: Key(data[index]['body']),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        setState(() {
                          data.removeAt(index);
                        });
                      },
                      background: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFE6E6),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Spacer(),
                          ],
                        ),
                      ),
                      child: NotificationCard(
                          title: data[index]['title'], body: data[index]['body']),
                    ),
                  ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator(),);
        }
      }
    );
  }
}
