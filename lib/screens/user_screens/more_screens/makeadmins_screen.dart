import 'package:e_commerce1/models/user.dart';
import 'package:e_commerce1/services/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class MakeAdmins extends StatefulWidget {
  @override
  State<MakeAdmins> createState() => _MakeAdminsState();
}

class _MakeAdminsState extends State<MakeAdmins> {
  final List<Map> items = [
    {"title": "Karim mohamed", "sub": "karim1809252@miuegypt.edu.eg"}
  ];

  @override
  Widget build(BuildContext context) {
    const title = 'Mixed List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 20.0,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Admins"),
        ),
        body: FutureBuilder(
            future: context.read<ProfileProvider>().getAllUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<userD> data = snapshot.data as List<userD>;

                return ListView.builder(
                  // Let the ListView know how many items it needs to build.
                  itemCount: data.length,
                  // Provide a builder function. This is where the magic happens.
                  // Convert each item into a widget based on the type of item it is.
                  itemBuilder: (context, index) {
                    final item = data[index];
                    if (item.uid == context.read<ProfileProvider>().getUID()) {
                      return Container();
                    }
                    return ListTile(
                      title: Text(item.name),
                      subtitle: Text(item.email),
                      trailing: ElevatedButton(
                        child: Text(item.Type == "admin"
                            ? "remove admin"
                            : "make admin"),
                        onPressed: () {
                          if (item.Type == "admin") {
                            context.read<ProfileProvider>().removeAdmin(item.key);
                            setState(() {
                              item.Type = "user";
                            });
                          } else {
                            context.read<ProfileProvider>().makeAdmin(item.key);
                            setState(() {
                              item.Type = "admin";
                            });
                          }
                        },
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
