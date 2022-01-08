import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'globals.dart' as globals;

class MoreScreen extends StatefulWidget {
  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  SharedPreferences? prefs;
  Future<bool> isSignedIn() async {
    prefs = await SharedPreferences.getInstance();
    return await prefs!.getBool("isLoggedIn")!;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: isSignedIn(),
        builder: (context, snapshot) {
          print(snapshot.connectionState);
          if (snapshot.hasData || snapshot.connectionState == ConnectionState.done) {
            return Column(
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
                          style: TextStyle(color: Color(0xff0088ff),
                              fontSize: 35.0),
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
                  leading: const Icon(
                      Icons.contact_mail, color: Color(0xff0088ff)),
                  title: const Text("Contact us"),
                  onTap: () {
                    Navigator.pushNamed(context, "/contact");
                  },
                ),
                if(snapshot.data!=true)ListTile(
                  leading: const Icon(Icons.login, color: Color(0xff0088ff)),
                  title: Text("Login"),
                  onTap: () {
                    Navigator.pushNamed(context, "/login");
                  },
                ),
                if(snapshot.data!=true)ListTile(
                  leading:
                  const Icon(Icons.app_registration, color: Color(0xff0088ff)),
                  title: const Text("Register"),
                  onTap: () {
                    Navigator.pushNamed(context, "/Register");
                  },
                ),
                if(snapshot.data==true)ListTile(
                  leading:
                  const Icon(Icons.reorder, color: Color(0xff0088ff)),
                  title: const Text("Your orders"),
                  onTap: () {
                    globals.currentTab.value = 6;
                  },
                ),
                if(snapshot.data==true)ListTile(
                  leading:
                  const Icon(Icons.logout, color: Color(0xff0088ff)),
                  title: const Text("Logout"),
                  onTap: () {
                    prefs!.setBool("isLoggedIn", false);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/', (Route<dynamic> route) => false);
                  },
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
      ),
    );
  }
}
