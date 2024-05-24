import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:smartcredit/controller/AddController.dart';
import 'package:smartcredit/controller/DataController.dart';
import 'package:velocity_x/velocity_x.dart';

class AddRepresentative extends StatefulWidget {
  DataController controller;
  AddRepresentative({super.key, required this.controller});

  @override
  State<AddRepresentative> createState() => Add_RepresentativeState();
}

class Add_RepresentativeState extends State<AddRepresentative> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final addController = Get.put(AddController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Add Representative".text.make(),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: context.width,
          child: Form(
            key: _formKey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                // CircleAvatar(
                //   radius: 50,
                //   child: Icon(Icons.image),
                //   backgroundColor: Colors.grey,
                // ),
                // 20.heightBox,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        labelText: "Representative Name",
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter representative name';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(
                        labelText: "Address", border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter address';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                        labelText: "Contact", border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter contact number';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                        labelText: "Username", border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter username';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "Password", border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                    width: context.width * 0.9,
                    margin: EdgeInsets.only(top: 20),
                    child: FilledButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            addController.addRepresentative(
                                context, widget.controller,
                                name: nameController.text,
                                username: usernameController.text,
                                phone: phoneController.text,
                                address: addressController.text,
                                password: passwordController.text);
                          }
                        },
                        child: Text("Submit").p(15))),
                30.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
