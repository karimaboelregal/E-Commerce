import 'package:e_commerce1/services/auth_service.dart';
import 'package:e_commerce1/services/storage_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../../../services/auth_service.dart';
import 'package:file_picker/file_picker.dart';

class AddCategory extends StatefulWidget {
  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<State> _LoaderDialog = new GlobalKey<State>();
  late var filename = '';
  late var path = '';


  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Category"),
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
                        return "Please enter category name";
                      }
                      return null;
                    },
                    controller: nameController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.supervised_user_circle),
                      border: OutlineInputBorder(),
                      hintText: 'Enter your category name here',
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
                      hintText: "Enter category description here",
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
                              return null;
                            },
                            child: Text("Add images")),
                        ElevatedButton(onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            //storage.uploadFile(path, filename).then((value) => print("done"));
                            String? value = await context.read<AuthenticationService>().AddCategory(
                                name: nameController.text.trim(),
                                desc: descriptionController.text.trim(),
                                path: filename,);

                            if (value != null) {
                              showMyDialogError();
                            } else {
                              showMyDialogSuccess();
                            }
                          }
                        }, child: Text("Create Category"))
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
                Text('Category not added'),
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
                Text('Category added succesfully'),
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

  }

}