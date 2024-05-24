import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcredit/controller/AddMedicine.dart';
import 'package:velocity_x/velocity_x.dart';

class AddMedicine extends StatelessWidget{
  final controller = Get.put(AddMedicineController());
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: "Add Medicine".text.make(),
      ),
     body: GetBuilder<AddMedicineController>(
       builder: (_) {
         return SafeArea(
           child: SingleChildScrollView(
             child: Form(
              key: controller.formKey,
              child:Column(children: [
               
                  
                SizedBox(height: 20,),
               Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: controller.name,
                              decoration: InputDecoration(
                                  labelText: "Medicine Name", border: OutlineInputBorder()),
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
                            child:      DropdownButtonFormField(
                              

                              value:controller.selectedunit == null ? null :controller.selectedunit.toString(),
                            decoration: InputDecoration(
                                hintText: "Select Unit",
                                border: OutlineInputBorder()),
                            items: controller.unit
                                .map((element) => DropdownMenuItem(
                                    value: element,
                                    child: Row(
                                      children: [
                                        
                                        10.widthBox,
                                        Container(
                                          width: context.width * 0.7,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            // crossAxisAlignment:
                                            //     CrossAxisAlignment.start,
                                            children: [
                                              Text(element),
                                              
                                            ],
                                          ),
                                        ),
                                      ],
                                    )))
                                .toList(),
                            onChanged: (v) {
                              print(v);
                             controller.selectedunit = v.toString();
                            }),

                          ),
                           Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: controller.retailprice,
                              decoration: InputDecoration(
                                  labelText: "Retail price", border: OutlineInputBorder()),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter price';
                                }
                                return null;
                              },
                            ),
                          ),
                           Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: controller.sellprice,
                              decoration: InputDecoration(
                                  labelText: "Sell Price", border: OutlineInputBorder()),
                              validator: (value) {
                                if (value == null || value.isEmpty)
                                {
                                  return "Please enter price";
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
                                if (controller.formKey.currentState!.validate() ) {
                                  if(controller.selectedunit != null){
                                        
                                        if(controller.medupdate == true){
                                          controller.updatemedicine(context);
                                        }
                                   else{
                                     controller.addMedicine(context);
                                   }
                                    
                                  }
                                
                                }
                              },
                              child: Text("Submit").p(15))),
                      30.heightBox,
             ],),
             
             
              ),
           ),
         );
       }
     ),
   );
  }

}