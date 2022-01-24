import 'package:e_commerce1/models/category.dart';
import 'package:e_commerce1/screens/user_screens/more_screens/login.dart';
import 'package:e_commerce1/services/auth_service.dart';
import 'package:e_commerce1/services/storage_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../loader.dart';
import '../globals.dart' as globals;
import '../../../services/auth_service.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';

class AddProduct extends StatefulWidget {
  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<State> _LoaderDialog = new GlobalKey<State>();
  late var filename = '';
  late var path = '';
  String? dropdownValue;


  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new product"),
      ),
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
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter name";
                      }
                      return null;
                    },
                    controller: nameController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.supervised_user_circle),
                      border: OutlineInputBorder(),
                      hintText: 'Enter your name here',
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.5,
                    ),
                  ),
                  width: MediaQuery.of(context).size.width - 50,
                  child: FutureBuilder(
                    future: context.read<AuthenticationService>().getAllCategories(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Category>? categories = snapshot.data as List<Category>?;
                        return Expanded(
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            style: const TextStyle(color: Color(0xFF223555)),
                            onChanged: (String? value) {
                              setState(() {
                                dropdownValue = value;
                              });
                            },
                            hint:const Text("choose category"),
                            items:categories!.map<DropdownMenuItem<String>>((cat) {
                              return DropdownMenuItem<String>(
                                value: cat.title,
                                child: Text(cat.title),
                              );
                            }).toList(),
                          ),
                        );
                      }
                      else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter price";
                      }
                      return null;
                    },
                    controller: priceController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.supervised_user_circle),
                      border: OutlineInputBorder(),
                      hintText: 'Enter your price here',
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  child: TextFormField(
                    maxLines: 8,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter description";
                      }
                      return null;
                    },
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      hintText: "Enter description",
                      prefixIcon: Icon(Icons.email_rounded),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ButtonBar(
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              final results = await FilePicker.platform.pickFiles(
                                allowMultiple: false,
                                type: FileType.custom,
                                allowedExtensions: ['png','jpg','jpeg'],
                              );
                              if(results == null){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("no image selected"),
                                  ),
                                );
                                return null;
                              }
                              else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("image is selected"),
                                  ),
                                );
                              }
                              path = results.files.single.path!;
                              filename = results.files.single.name;
                            },
                            child: Text("Add images")),
                        ElevatedButton(onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            storage.uploadFile(path, filename).then((value) => print("done"));
                            String? value = await context.read<AuthenticationService>().AddProduct(
                                name: nameController.text.trim(),
                                desc: descriptionController.text.trim(),
                                type: dropdownValue,
                                path: filename,
                                price: priceController.text.trim());
                            if (value != null) {
                              showMyDialogError();
                            } else {
                              showMyDialogSuccess();
                            }
                          }
                        }, child: Text("Save Product"))
                      ],
                    ),
              ],
            ),
          ),
        )
    );
  }

  Future<void> showMyDialogError() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Product not added'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showMyDialogSuccess() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Product added succesfully'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('close'),
              onPressed: () {
                Navigator.of(context).pop();
                clearText();
              },
            ),
          ],
        );
      },
    );
  }

  void clearText() {
    nameController.clear();
    descriptionController.clear();
    typeController.clear();
    priceController.clear();
  }

}