import 'package:e_commerce1/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../loader.dart';
import '../globals.dart' as globals;
import '../../../services/auth_service.dart';

class AddProduct extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<State> _LoaderDialog = new GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ElevatedButton(onPressed: () { context.read<AuthenticationService>().AddProduct(); }, child: Text("add"),
      ),));
  }
}
