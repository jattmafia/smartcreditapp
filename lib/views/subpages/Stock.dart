import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcredit/controller/Stockcontroller.dart';
import 'package:smartcredit/views/data.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../navigator.dart';
import '../add/addstock.dart';
import 'showstock.dart';

class StockScreen extends StatefulWidget {
  final title = "Stock";
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  final controller = Get.put(StockController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<StockController>(builder: (_) {
        return SafeArea(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.title.text.bold.size(20).make(),
                FilledButton(
                    onPressed: () {
                      //controller.getuser();4
                      controller.stockupdate = false;
                      controller.quantity.clear();
                      controller.selectedmed = null;
                      controller.selecteduser = null;
                      navigateTo(context, AddStock());
                    },
                    child: "Add New".text.make())
              ],
            ).p(20),
            Expanded(
              child: ListView.builder(
                  controller: controller.controller,
                  shrinkWrap: true,
                  itemCount: controller.stock.length,
                  itemBuilder: (_, index) {
                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                            child: Text(controller.stock[index]["medicine"]
                                    ["medicineName"]
                                .toString()
                                .substring(0, 1)),
                          ),
                          10.widthBox,
                          GestureDetector(
                            onTap: () {
                              var yourTransactionData = controller.stock[index];
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return TransactionDetailsDialog(
                                      transactionData: yourTransactionData);
                                },
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(controller.stock[index]["medicine"]
                                            ["medicineName"] ==
                                        null
                                    ? "Not Available"
                                    : controller.stock[index]["medicine"]
                                        ["medicineName"]),
                                Text(controller.stock[index]["medicine"]
                                            ["medicineUnit"] ==
                                        null
                                    ? "Not Available"
                                    : controller.stock[index]["medicine"]
                                        ["medicineUnit"])
                              ],
                            ),
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
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight:
                                                      Radius.circular(20)),
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
                                                    child: "Delete".text.make(),
                                                    onPressed: () {
                                                      var id = controller
                                                          .stock[index]["id"];
                                                      back(context);
                                                      controller.deletestock(
                                                          context, id, index);
                                                    }),
                                              ),
                                              Spacer(),
                                              Container(
                                                width: context.width,
                                                child: CupertinoButton(
                                                    child: "Edit".text.make(),
                                                    onPressed: () {
                                                      controller.quantity.text =
                                                          controller
                                                              .stock[index]
                                                                  ["quantity"]
                                                              .toString();
                                                      // controller.selectedmed = controller.stock[index]["medicine"]["id"].toString();

                                                      //    var initialValue = controller.stock[index]["medicine"]["id"];
                                                      controller.selectedmed = {
                                                        "id": controller
                                                                .stock[index]
                                                            ["medicine"]["id"]
                                                      };
                                                      controller
                                                          .medid = controller
                                                              .stock[index]
                                                          ["medicine"]["id"];

                                                      controller.selecteduser =
                                                          {
                                                        "id": controller
                                                                .stock[index]
                                                            ["user"]["id"]
                                                      };
                                                      controller.userid =
                                                          controller
                                                                  .stock[index]
                                                              ["user"]["id"];
                                                      controller.stockid =
                                                          controller
                                                                  .stock[index]
                                                              ["id"];
                                                      controller.update();
                                                      controller.update();

                                                      controller.stockupdate =
                                                          true;
                                                      controller.stockindex =
                                                          index;
                                                      back(context);
                                                      navigateTo(
                                                          context, AddStock());
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
                    );
                  }),
            ),
         
          ],
        ));
      }),
    );
  }
}
