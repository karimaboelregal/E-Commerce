import 'package:e_commerce1/services/auth_service.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
              height: 60,
            ),
            Center(child: Text("Username")),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width - 50,
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.supervised_user_circle),
                  border: OutlineInputBorder(),
                  hintText: 'Enter your email here',
                ),
              ),
            ),
            SizedBox(height: 20),
            const Center(child: Text("Password")),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: TextFormField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  hintText: "****",
                  prefixIcon: Icon(Icons.security_rounded),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
                width: 100,
                child: ElevatedButton(onPressed: () async {
                  globals.currentTab.value = 0;
                  await context.read<AuthenticationService>().signIn(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim());
                }, child: Text("Login"))),
            InkWell(onTap: () {globals.currentTab.value = 5;}, child: Container(height: 30, width: 300, child: Center(child: Text("Dont have an account yet? Click here to signup")))),
            WillPopScope(
                onWillPop: () {
                  print("hi");
                  globals.currentTab.value = 3;
                  return Future.value(false);
                },
                child: Text('')),
          ],
        ),
      ),
    );
  }
}
