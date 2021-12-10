import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class MoreScreen extends StatefulWidget {
  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
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
            leading: const Icon(
              Icons.info,
              color: Color(0xff0088ff),
            ),
            title: Text("News"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail, color: Color(0xff0088ff)),
            title: const Text("Contact us"),
            onTap: () {
              globals.currentTab.value = 3;
            },
          ),
          ListTile(
            leading: const Icon(Icons.login, color: Color(0xff0088ff)),
            title: Text("Login"),
            onTap: () {
              globals.currentTab.value = 4;
            },
          ),
          ListTile(
            leading:
            const Icon(Icons.app_registration, color: Color(0xff0088ff)),
            title: const Text("Register"),
            onTap: () {
              globals.currentTab.value = 5;
            },
          ),
          ListTile(
            leading:
            const Icon(Icons.reorder, color: Color(0xff0088ff)),
            title: const Text("Your orders"),
            onTap: () {
              globals.currentTab.value = 6;
            },
          ),
        ],
      ),
    );
  }
}
