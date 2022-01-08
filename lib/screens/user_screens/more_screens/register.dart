import 'package:e_commerce1/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../loader.dart';
import '../globals.dart' as globals;

class Register extends StatelessWidget {
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
              Center(child: Text("Name")),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width - 50,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter name";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.supervised_user_circle),
                    border: OutlineInputBorder(),
                    hintText: 'Enter your name here',
                  ),
                ),
              ),
              SizedBox(height: 20),
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
                    hintText: "Enter your e-mail address here",
                    prefixIcon: Icon(Icons.email_rounded),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Center(child: Text("Password")),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width - 50,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    }
                    return null;
                  },
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "****",
                    prefixIcon: Icon(Icons.security_rounded),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(child: Text("Confirm password")),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width - 50,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter confirm password";
                    } else if (value != passwordController.text.trim()) {
                      return "Passwords dont match";
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "****",
                    prefixIcon: Icon(Icons.security_rounded),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                  width: 100,
                  child: ElevatedButton(onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      LoaderDialog.showLoadingDialog(
                          context, _LoaderDialog);
                      String? value = await context
                          .read<AuthenticationService>()
                          .signUp(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim());
                      Navigator.of(_LoaderDialog.currentContext!,
                          rootNavigator: true)
                          .pop();
                      if (value != "Signed up") {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(value!)));
                      } else {
                        Navigator.pushNamed(context, "/login");
                      }
                    }
                  }, child: Text("Register"))),
            ],
          ),
        ),
      ),
    );
  }
}
