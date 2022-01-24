import 'package:e_commerce1/services/auth_service.dart';
import 'package:e_commerce1/services/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'globals.dart' as globals;

class MoreScreen extends StatefulWidget {
  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  SharedPreferences? prefs;

  @override
  Widget build(BuildContext context) {
    bool isSignedin = context.read<ProfileProvider>().isLoggedin();
    bool isAdmin = context.read<ProfileProvider>().isAdmin();
    return Scaffold(
        body: Column(
      children: [
        SizedBox(height: 80),
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
        const SizedBox(
          height: 50,
        ),
        ListTile(
          leading: const Icon(Icons.contact_mail, color: Color(0xff0088ff)),
          title: const Text("Contact us"),
          onTap: () {
            Navigator.pushNamed(context, "/contact");
          },
        ),
        if (isSignedin != true)
          ListTile(
            leading: const Icon(Icons.login, color: Color(0xff0088ff)),
            title: Text("Login"),
            onTap: () {
              Navigator.pushNamed(context, "/login");
            },
          ),
        if (isSignedin != true)
          ListTile(
            leading:
                const Icon(Icons.app_registration, color: Color(0xff0088ff)),
            title: const Text("Register"),
            onTap: () {
              Navigator.pushNamed(context, "/Register");
            },
          ),
        if (isSignedin == true)
          ListTile(
            leading: const Icon(Icons.reorder, color: Color(0xff0088ff)),
            title: const Text("Your orders"),
            onTap: () {
              Navigator.pushNamed(context, "/orders");
              globals.currentTab.value = 6;
            },
          ),
        if (isAdmin)
          ListTile(
            leading: const Icon(Icons.reorder, color: Color(0xff0088ff)),
            title: const Text("Add product"),
            onTap: () {
              Navigator.pushNamed(context, "/addproduct_screen");
            },
          ),
        if (isAdmin)
          ListTile(
            leading: const Icon(Icons.add_box_outlined, color: Color(0xff0088ff)),
            title: const Text("Add Category"),
            onTap: () {
              Navigator.pushNamed(context, "/addcategory_screen");
            },
          ),
        if (isSignedin == true)
          ListTile(
            leading: const Icon(Icons.logout, color: Color(0xff0088ff)),
            title: const Text("Logout"),
            onTap: () {
              context.read<AuthenticationService>().signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (Route<dynamic> route) => false);
            },
          ),
      ],
    ));
  }
}
