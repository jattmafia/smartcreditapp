import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';
import 'package:smartcredit/controller/Stockcontroller.dart';
import 'package:velocity_x/velocity_x.dart';

class AddStock extends StatelessWidget {
  final controller = Get.put(StockController());
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(
        title: "Add Stock".text.make(),
      ),
    body: SafeArea(
      
      child: Form(
      key: controller.formKey,
      child: Column(children: [
        SizedBox(height: 20,),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: DropdownButtonFormField(
            value:controller.selectedmed == null ? null :  controller.selecteduser["id"],
                                decoration: InputDecoration(
                                    hintText: "Select Representative",
                                    border: OutlineInputBorder()),
                                items: controller.users
                                    .map((element) => DropdownMenuItem(
                                        value: element["id"],
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
                                   print(v.runtimeType);
                              // Map<String, dynamic>? myObject = v as Map<String, dynamic>?;
                                  controller.userid =int.parse(v.toString());
                                  print(controller.userid);
                                }),
         ),
      
      
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: DropdownButtonFormField(
           value: controller.selectedmed == null ? null : controller.selectedmed['id'],
                                decoration: InputDecoration(
                                    hintText: "SelecMedicine",
                                    border: OutlineInputBorder()),
                                items: controller.meds
                                    .map((element) => DropdownMenuItem(
                                        value: element["id"],
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              child: Icon(Icons.medication_outlined),
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
                                                  Text(element['medicineName']),
                                                  // Text(
                                                  //   "MR0000" ,
                                                        //element['id'].toString(),
                                                    //style: TextStyle(fontSize: 10),
                                                //  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        )))
                                    .toList(),
                                onChanged: (v) {
                                  print(v);
                             // Map<String, dynamic>? myObject = v as Map<String, dynamic>?;
                                  controller.medid = int.parse(v.toString());
                                  print(controller.medid);
                                }),
         ),
      
      
          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: controller.quantity,
                                decoration: InputDecoration(
                                    labelText: "quantity", border: OutlineInputBorder()),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter quantity';
                                  }
                                  return null;
                                },
                              ),
                            ),
      
      
       controller.addloading ?
                           Center(child: Padding(
                             padding: const EdgeInsets.only(top: 20),
                             child: CircularProgressIndicator(),
                           )):
                           Container(
                          width: context.width * 0.9,
                          margin: EdgeInsets.only(top: 20),
                          child: FilledButton(
                              onPressed: () {
                                if (controller.formKey.currentState!.validate()) {
                                  if(controller.userid !=null && controller.medid != null ){

                                    if(controller.stockupdate == true){
                                      controller.updatestock(context);
                                    }
                                    else{
                                       controller.adstock(context);
                                    }
                                }
                                }
                              },
                              child: Text("Submit").p(15))),
                      30.heightBox,
                            
      
       
      
      ],
      ),
    ),)
   );
  }

}