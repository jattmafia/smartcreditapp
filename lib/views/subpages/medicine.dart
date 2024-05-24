import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:smartcredit/controller/AddMedicine.dart';
import 'package:smartcredit/navigator.dart';
import 'package:smartcredit/views/add/AddMedicine.dart';
import 'package:smartcredit/views/subpages/medicinedetail.dart';
import 'package:velocity_x/velocity_x.dart';

class MedicineScreen extends StatefulWidget {
  final title = "Medicine";
  const MedicineScreen({super.key});

  @override
  State<MedicineScreen> createState() => _MedicineScreenState();
}

class _MedicineScreenState extends State<MedicineScreen> {
  final controller = Get.put(AddMedicineController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddMedicineController>(
      builder: (_) {
        return Column(
          children: [
            Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widget.title.text.bold.size(20).make(),
                      FilledButton(
                        
                         
                          
                          onPressed: () { 
                            controller.medupdate = false;
                            controller.name.clear();
                            controller.retailprice.clear();
                            controller.sellprice.clear();
                            controller.selectedunit = null;
                            controller.update();
                           navigateTo(context, AddMedicine());
                           },
                          child: "Add New".text.make())
                    ],
                  ).p(20),
        
                      Expanded(
                        child: ListView.builder(
                          controller: controller.controller,
                            shrinkWrap: true,
                            itemCount:controller.medicines.length,
                            itemBuilder: (_, index) {
                             
                              return GestureDetector(
                                onTap: (){
                                    showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      var medicineData = controller.medicines[index];
                                      return MedicineDetailsDialog(medicineData: medicineData);
                                    },);
                                },
                                child: Card(
                                  elevation: 5,
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Row(children: [
                                      CircleAvatar(
                                          // backgroundImage:
                                              //  widget.isImage
                                              //     ?
                                              // NetworkImage(
                                              //     _dataController.data[index]['image'])
                                          //     : null,
                                          child:Text(controller.medicines[index]["medicineName"].toString().substring(0,1)),
                                          ),
                                      10.widthBox,
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(controller.medicines[index]
                                              ["medicineName"]),
                                          Text(controller.medicines[index]
                                              ["medicineUnit"])
                                        ],
                                      ),
                                      Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            showCupertinoModalPopup(
                                                context: context,
                                                builder: (_) {
                                                  return ConstrainedBox(
                                                    constraints:
                                                        BoxConstraints(maxHeight: 180),
                                                    child: Container(
                                                      width: context.width,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft:
                                                                      Radius.circular(
                                                                          20),
                                                                  topRight:
                                                                      Radius.circular(
                                                                          20)),
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            // BoxShadow(
                                                            //   color: Colors.black54,
                                                            //   offset: Offset(0.0, 1),
                                                            //   blurRadius: 10.0,
                                                            // )
                                                          ]),
                                                      child: Column(
                                                        children: [
                                                          Spacer(),
                                                         
                                                          Spacer(),
                                                          Container(
                                                            width: context.width,
                                                            child: CupertinoButton(
                                                                child: "Delete"
                                                                    .text
                                                                    .make(),
                                                                onPressed: () {
                                                                  var id = controller.medicines[index]["id"];
                                                                  back(context);
                                                                  controller.deletemedicine(context, id,index);
                                                                }),
                                                          ),
                                                          Spacer(),
                                                          Container(
                                                            width: context.width,
                                                            child: CupertinoButton(
                                                                child:
                                                                    "Edit"
                                                                        .text
                                                                        .make(),
                                                                onPressed: () {
                                                                  controller.name.text = controller.medicines[index]["medicineName"];
                                                                  controller.retailprice.text =  controller.medicines[index]["retailPrice"].toString();
                                                                  controller.sellprice.text =  controller.medicines[index]["sellPrice"].toString();
                                                                  controller.selectedunit =  controller.medicines[index]["medicineUnit"];
                                                                  controller.medid = controller.medicines[index]["id"];
                                                                  controller.update();
                                                                  print(controller.selectedunit);
                                                                  controller.medupdate = true;
                                                                  controller.medindex = index;
                                                                  back(context);
                                                                   navigateTo(context, AddMedicine());
                                                                }),
                                                          ),
                                                          
                                                          Spacer(),
                                                          Container(
                                                            width: context.width,
                                                            child: CupertinoButton(
                                                                child: "Cancel"
                                                                    .text
                                                                    .color(Colors.red)
                                                                    .make(),
                                                                onPressed: () {
                                                                  back(context);
                                                                }),
                                                          ),
                                                          Spacer(),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                         
                                          },
                                          icon: Icon(Icons.more_vert))
                                    ]),
                                  ),
                                ),
                              );
                            }),
                      ),
        
          ],
        );
      }
    );
  }
}
