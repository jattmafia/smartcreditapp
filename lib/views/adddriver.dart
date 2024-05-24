import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

import '../services/HttpService.dart';

class AddDriver extends StatefulWidget {
  @override
  State<AddDriver> createState() => _AddDriverState();
}

class _AddDriverState extends State<AddDriver> {
  TextEditingController emailcontroller = TextEditingController();

  TextEditingController usernamecontroller = TextEditingController();

  TextEditingController passwordcontroller = TextEditingController();

  TextEditingController namecontroller = TextEditingController();

  TextEditingController phonecontroller = TextEditingController();

  TextEditingController addresscontroller = TextEditingController();

  final ImagePicker picker = ImagePicker();

  final driverImage = Rxn<XFile>();

  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: "Add Driver".text.make(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  driverImage(image);
                  setState(() {});
                }
              },
              child: CircleAvatar(
                radius: 50,
                backgroundImage: driverImage.value != null
                    ? FileImage(File(driverImage.value!.path))
                    : null,
                child: Icon(Icons.image),
                backgroundColor: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: emailcontroller,
                decoration: InputDecoration(
                    labelText: "Email",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.transparent)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.transparent)),
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    prefixIcon: Icon(Icons.mail)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: usernamecontroller,
                decoration: InputDecoration(
                    labelText: "Username",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.transparent)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.transparent)),
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    prefixIcon: Icon(Icons.person)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: passwordcontroller,
                decoration: InputDecoration(
                    labelText: "Password",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.transparent)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.transparent)),
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    prefixIcon: Icon(Icons.lock)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: namecontroller,
                decoration: InputDecoration(
                    labelText: "Name",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.transparent)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.transparent)),
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    prefixIcon: Icon(Icons.person)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: phonecontroller,
                decoration: InputDecoration(
                    labelText: "Phone",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.transparent)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.transparent)),
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    prefixIcon: Icon(Icons.phone)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: addresscontroller,
                decoration: InputDecoration(
                    labelText: "Address",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.transparent)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.transparent)),
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    prefixIcon: Icon(Icons.phone)),
              ),
            ),
            loading
                ? const CircularProgressIndicator()
                : FilledButton(
                        style: ButtonStyle(
                            backgroundColor:
                                const MaterialStatePropertyAll(Colors.green),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                        onPressed: () {
                          if (usernamecontroller.text.isEmptyOrNull ||
                              emailcontroller.text.isEmptyOrNull ||
                              passwordcontroller.text.isEmptyOrNull ||
                              phonecontroller.text.isEmptyOrNull ||
                              namecontroller.text.isEmptyOrNull ||
                              addresscontroller.text.isEmptyOrNull ||
                              driverImage.value == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text("Please Fill All Fields")));
                          } else {
                            adddata(context);
                          }
                        },
                        child: "Save".text.make())
                    .p(20)
          ],
        ),
      ),
    );
  }

  void adddata(context) async {
    loading = true;
    setState(() {});
    http.StreamedResponse response = await HttpService.postdoc(
        tabel: "driver/create",
        query: {
          "username": usernamecontroller.text,
          "password": passwordcontroller.text,
          "name": namecontroller.text,
          "email": emailcontroller.text,
          "phone": phonecontroller.text,
          "address": addresscontroller.text,
        },
        image: File(driverImage.value!.path));

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.green, content: Text("Driver Added")));

      usernamecontroller.clear();
      passwordcontroller.clear();
      namecontroller.clear();
      emailcontroller.clear();
      phonecontroller.clear();
      addresscontroller.clear();
      loading = false;
      setState(() {});
      return;
    } else {
      var a = await response.stream.bytesToString();
      var b = jsonDecode(a);

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red, content: Text(b)));
      loading = false;
      setState(() {});
      return;
    }
  }
}
