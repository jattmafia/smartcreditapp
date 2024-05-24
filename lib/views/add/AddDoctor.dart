// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartcredit/controller/AddController.dart';
import 'package:smartcredit/controller/DataController.dart';
import 'package:velocity_x/velocity_x.dart';

class AddDoctor extends StatefulWidget {
  DataController controller;
  AddDoctor({super.key, required this.controller});

  @override
  State<AddDoctor> createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {
  final ImagePicker picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final addController = Get.put(AddController());

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await Future.delayed(Duration(milliseconds: 100));
    addController.loadMrs(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Add Doctor".text.make(),
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
                GestureDetector(
                  onTap: () async {
                    XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      addController.doctorImage(image);
                    }
                  },
                  child: Obx(() => CircleAvatar(
                        radius: 50,
                        backgroundImage: addController.doctorImage.value != null
                            ? FileImage(
                                File(addController.doctorImage.value!.path))
                            : null,
                        child: Icon(Icons.image),
                        backgroundColor: Colors.grey,
                      )),
                ),
                // 20.heightBox,
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(() => addController.isLoading.value
                        ? LinearProgressIndicator()
                        : DropdownButtonFormField(
                            decoration: InputDecoration(
                                hintText: "Select Representative",
                                border: OutlineInputBorder()),
                            items: addController.mrList
                                .map((element) => DropdownMenuItem(
                                    value: element,
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          child: Icon(Icons.person),
                                        ),
                                        10.widthBox,
                                        Container(
                                          width: context.width * 0.7,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            // crossAxisAlignment:
                                            //     CrossAxisAlignment.start,
                                            children: [
                                              Text(element['name']),
                                              Text(
                                                "MR0000" +
                                                    element['id'].toString(),
                                                style: TextStyle(fontSize: 10),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    )))
                                .toList(),
                            onChanged: (v) {
                              addController.selectedUser(v);
                            }))),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        labelText: "Name", border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter name';
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
                Container(
                    width: context.width * 0.9,
                    margin: EdgeInsets.only(top: 20),
                    child: FilledButton(
                        onPressed: () async {
                          bool serviceEnabled =
                              await Geolocator.isLocationServiceEnabled();
                          if (!serviceEnabled) {
                            Get.snackbar(
                                "Error", "Location services are disabled");
                            return;
                          }

                          var permission = await Geolocator.checkPermission();
                          if (permission == LocationPermission.denied) {
                            permission = await Geolocator.requestPermission();
                            if (permission == LocationPermission.denied) {
                              Get.snackbar(
                                  "Error", "Location permissions are denied");
                              return;
                            }
                          }

                          if (permission == LocationPermission.deniedForever) {
                            Get.snackbar("Error",
                                "Location permissions are permanently denied, we cannot request permissions.");
                            return;
                          } else {
                            addController.picklocation();
                          }
                        },
                        child: Text("Pick Location").p(15))),
                25.heightBox,

                Container(
                    width: context.width * 0.9,
                    margin: EdgeInsets.only(top: 20),
                    child: FilledButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              addController.doctorImage.value != null) {
                            if (addController.position == null) {
                              
                              Get.snackbar("Error", "Please Select Location");
                              return;
                            } else {
                              addController.addDoctor(
                                  nameController.text,
                                  addressController.text,
                                  phoneController.text,
                                  context,
                                  widget.controller);
                            }
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
