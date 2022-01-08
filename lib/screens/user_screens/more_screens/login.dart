import 'package:e_commerce1/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../loader.dart';
import '../globals.dart' as globals;

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<State> _LoaderDialog = new GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
              Center(child: Text("Email")),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width - 50,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter email";
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter password";
                    }
                    return null;
                  },
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
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          LoaderDialog.showLoadingDialog(
                              context, _LoaderDialog);
                          String? value = await context
                              .read<AuthenticationService>()
                              .signIn(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim());

                          Navigator.of(_LoaderDialog.currentContext!,
                                  rootNavigator: true)
                              .pop();
                          if (value != "Signed in") {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(value!)));
                          } else {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/', (Route<dynamic> route) => false);
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setBool("isLoggedIn", true);
                            prefs.setString("Email", emailController.text.trim());
                          }
                        }
                      },
                      child: Text("Login"))),
              InkWell(
                  onTap: () {
                    globals.currentTab.value = 5;
                  },
                  child: Container(
                      height: 30,
                      width: 300,
                      child: Center(
                          child: Text(
                              "Dont have an account yet? Click here to signup")))),
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
      ),
    );
  }
}

