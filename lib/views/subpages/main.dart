import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:smartcredit/controller/DataController.dart';
import 'package:smartcredit/controller/MainController.dart';
import 'package:smartcredit/navigator.dart';
import 'package:smartcredit/views/drivers.dart';
import 'package:smartcredit/views/subpages/alldrivers.dart';
import 'package:smartcredit/views/subpages/receivedialog.dart';
import 'package:smartcredit/views/subpages/selldialog.dart';
import 'package:velocity_x/velocity_x.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  final controller = Get.put(MainController());
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 2));
        return Future.value(true);
      },
      child: GetBuilder<MainController>(builder: (_) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      "Total Balance".text.bold.size(18).make(),
                      controller.totalprice.toString().text.size(22).make(),
                    ],
                  ).p(20).pOnly(top: 10),
                ).pOnly(left: 10),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: GestureDetector(
                          onTap: () {
                            // navigateTo(context, SellMedicineDialog());
                            //SellMedicineDialog();
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SellMedicineDialog();
                              },
                            );
                          },
                          child: Card(
                            elevation: 5,
                            child: Expanded(
                              child: Column(
                                children: [
                                  Icon(Icons.sell),
                                  "Sell".text.size(10).make()
                                ],
                              ).p(4),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Card(
                          elevation: 5,
                          child: Expanded(
                            child: Column(
                              children: [
                                Icon(Icons.medical_services_rounded),
                                "Doctors".text.size(10).make()
                              ],
                            ).p(4),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ReceiveMedicineDialog();
                              },
                            );
                          },
                          child: Card(
                            elevation: 5,
                            child: Column(
                              children: [
                                Icon(Icons.download_sharp),
                                "Recieve".text.size(10).make()
                              ],
                            ).p(4),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Card(
                          elevation: 5,
                          child: Column(
                            children: [
                              Icon(Icons.medication_liquid_outlined),
                              "Medicine".text.size(10).make()
                            ],
                          ).p(4),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: Card(
                          elevation: 5,
                          child: Column(
                            children: [
                              Icon(Icons.data_exploration),
                              "Stocks".text.size(10).make()
                            ],
                          ).p(4),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: GestureDetector(
                          onTap: () {
                            navigateTo(context, AllDriver());
                            //navigateTo(context, DriverScreen());
                          },
                          child: Card(
                            elevation: 5,
                            child: Column(
                              children: [
                                Icon(Icons.local_taxi_outlined),
                                "Drivers".text.size(10).make()
                              ],
                            ).p(4),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ).pOnly(right: 10, bottom: 10),
            TabBar(
              automaticIndicatorColorAdjustment: true,
              dividerColor: Colors.transparent,
              unselectedLabelColor: Colors.black,
              labelColor: Colors.white,
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                //border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.blue,
              ),
              tabs: const [
                Tab(
                  text: 'Sell',
                ),
                Tab(text: 'Gift'),
                Tab(
                  text: "Receive",
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: controller.sell.length,
                      controller: controller.sellcontroller,
                      itemBuilder: (_, i) {
                        return Card(
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    controller.sell[i]["doctor"]["image"]),
                              ),
                              10.widthBox,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(controller.sell[i]["doctor"]["name"]),
                                  Text(controller.sell[i]["medicine"]
                                      ["medicineName"])
                                ],
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  Text(
                                    controller.sell[i]["totalPrice"].toString(),
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        // showCupertinoModalPopup(
                                        //     context: context,
                                        //     builder: (_) {
                                        //       return ConstrainedBox(
                                        //         constraints:
                                        //             BoxConstraints(maxHeight: 300),
                                        //         child: Container(
                                        //           width: context.width,
                                        //           decoration: BoxDecoration(
                                        //               borderRadius: BorderRadius.only(
                                        //                   topLeft:
                                        //                       Radius.circular(20),
                                        //                   topRight:
                                        //                       Radius.circular(20)),
                                        //               color: Colors.white,
                                        //               boxShadow: [
                                        //                 // BoxShadow(
                                        //                 //   color: Colors.black54,
                                        //                 //   offset: Offset(0.0, 1),
                                        //                 //   blurRadius: 10.0,
                                        //                 // )
                                        //               ]),
                                        //           child: Column(
                                        //             children: [
                                        //               Spacer(),
                                        //               Container(
                                        //                 width: context.width,
                                        //                 child: CupertinoButton(
                                        //                     child: "Call Doctor"
                                        //                         .text
                                        //                         .make(),
                                        //                     onPressed: () async{
                                        //                       var number =dataController.data[i]['phone']; //set the number here

                                        //                             await FlutterPhoneDirectCaller
                                        //                                 .callNumber(number);
                                        //                     }),
                                        //               ),
                                        //               Spacer(),
                                        //               Container(
                                        //                 width: context.width,
                                        //                 child: CupertinoButton(
                                        //                     child: "Account Details"
                                        //                         .text
                                        //                         .make(),
                                        //                     onPressed: () {}),
                                        //               ),
                                        //               Spacer(),
                                        //               Container(
                                        //                 width: context.width,
                                        //                 child: CupertinoButton(
                                        //                     child:
                                        //                         "Sell Medicine Details"
                                        //                             .text
                                        //                             .make(),
                                        //                     onPressed: () {}),
                                        //               ),
                                        //               Spacer(),
                                        //               Container(
                                        //                 width: context.width,
                                        //                 child: CupertinoButton(
                                        //                     child: "Send Message"
                                        //                         .text
                                        //                         .make(),
                                        //                     onPressed: () {}),
                                        //               ),
                                        //               Spacer(),
                                        //               Container(
                                        //                 width: context.width,
                                        //                 child: CupertinoButton(
                                        //                     child: "Cancel"
                                        //                         .text
                                        //                         .color(Colors.red)
                                        //                         .make(),
                                        //                     onPressed: () {
                                        //                       back(context);
                                        //                     }),
                                        //               ),
                                        //               Spacer(),
                                        //             ],
                                        //           ),
                                        //         ),
                                        //       );
                                        //     });
                                      },
                                      icon: Icon(Icons.more_vert)),
                                ],
                              )
                            ]),
                          ),
                        );
                      }),
                  ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      controller: controller.sellcontroller,
                      itemCount: controller.gift.length,
                      itemBuilder: (_, i) {
                        return Card(
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    controller.gift[i]["doctor"]["image"]),
                              ),
                              10.widthBox,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(controller.gift[i]["doctor"]["name"]),
                                  Text(controller.gift[i]["medicine"]
                                      ["medicineName"])
                                ],
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  Text(
                                    controller.gift[i]["totalPrice"].toString(),
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        // showCupertinoModalPopup(
                                        //     context: context,
                                        //     builder: (_) {
                                        //       return ConstrainedBox(
                                        //         constraints:
                                        //             BoxConstraints(maxHeight: 300),
                                        //         child: Container(
                                        //           width: context.width,
                                        //           decoration: BoxDecoration(
                                        //               borderRadius: BorderRadius.only(
                                        //                   topLeft:
                                        //                       Radius.circular(20),
                                        //                   topRight:
                                        //                       Radius.circular(20)),
                                        //               color: Colors.white,
                                        //               boxShadow: [
                                        //                 // BoxShadow(
                                        //                 //   color: Colors.black54,
                                        //                 //   offset: Offset(0.0, 1),
                                        //                 //   blurRadius: 10.0,
                                        //                 // )
                                        //               ]),
                                        //           child: Column(
                                        //             children: [
                                        //               Spacer(),
                                        //               Container(
                                        //                 width: context.width,
                                        //                 child: CupertinoButton(
                                        //                     child: "Call Doctor"
                                        //                         .text
                                        //                         .make(),
                                        //                     onPressed: () async{
                                        //                       var number =dataController.data[i]['phone']; //set the number here

                                        //                             await FlutterPhoneDirectCaller
                                        //                                 .callNumber(number);
                                        //                     }),
                                        //               ),
                                        //               Spacer(),
                                        //               Container(
                                        //                 width: context.width,
                                        //                 child: CupertinoButton(
                                        //                     child: "Account Details"
                                        //                         .text
                                        //                         .make(),
                                        //                     onPressed: () {}),
                                        //               ),
                                        //               Spacer(),
                                        //               Container(
                                        //                 width: context.width,
                                        //                 child: CupertinoButton(
                                        //                     child:
                                        //                         "Sell Medicine Details"
                                        //                             .text
                                        //                             .make(),
                                        //                     onPressed: () {}),
                                        //               ),
                                        //               Spacer(),
                                        //               Container(
                                        //                 width: context.width,
                                        //                 child: CupertinoButton(
                                        //                     child: "Send Message"
                                        //                         .text
                                        //                         .make(),
                                        //                     onPressed: () {}),
                                        //               ),
                                        //               Spacer(),
                                        //               Container(
                                        //                 width: context.width,
                                        //                 child: CupertinoButton(
                                        //                     child: "Cancel"
                                        //                         .text
                                        //                         .color(Colors.red)
                                        //                         .make(),
                                        //                     onPressed: () {
                                        //                       back(context);
                                        //                     }),
                                        //               ),
                                        //               Spacer(),
                                        //             ],
                                        //           ),
                                        //         ),
                                        //       );
                                        //     });
                                      },
                                      icon: Icon(Icons.more_vert)),
                                ],
                              )
                            ]),
                          ),
                        );
                      }),
                  ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      controller: controller.receivecontroller,
                      itemCount: controller.receive.length,
                      itemBuilder: (_, i) {
                        return Card(
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    controller.receive[i]["doctor"]["image"]),
                              ),
                              10.widthBox,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(controller.receive[i]["sellPrice"]
                                      .toString()),
                                  Text(controller.receive[i]["receivedAmount"]
                                      .toString())
                                ],
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  // Text(
                                  //   controller.gift[i]["totalPrice"].toString(),
                                  //   style: TextStyle(color: Colors.green),
                                  // ),
                                  IconButton(
                                      onPressed: () {
                                        // showCupertinoModalPopup(
                                        //     context: context,
                                        //     builder: (_) {
                                        //       return ConstrainedBox(
                                        //         constraints:
                                        //             BoxConstraints(maxHeight: 300),
                                        //         child: Container(
                                        //           width: context.width,
                                        //           decoration: BoxDecoration(
                                        //               borderRadius: BorderRadius.only(
                                        //                   topLeft:
                                        //                       Radius.circular(20),
                                        //                   topRight:
                                        //                       Radius.circular(20)),
                                        //               color: Colors.white,
                                        //               boxShadow: [
                                        //                 // BoxShadow(
                                        //                 //   color: Colors.black54,
                                        //                 //   offset: Offset(0.0, 1),
                                        //                 //   blurRadius: 10.0,
                                        //                 // )
                                        //               ]),
                                        //           child: Column(
                                        //             children: [
                                        //               Spacer(),
                                        //               Container(
                                        //                 width: context.width,
                                        //                 child: CupertinoButton(
                                        //                     child: "Call Doctor"
                                        //                         .text
                                        //                         .make(),
                                        //                     onPressed: () async{
                                        //                       var number =dataController.data[i]['phone']; //set the number here

                                        //                             await FlutterPhoneDirectCaller
                                        //                                 .callNumber(number);
                                        //                     }),
                                        //               ),
                                        //               Spacer(),
                                        //               Container(
                                        //                 width: context.width,
                                        //                 child: CupertinoButton(
                                        //                     child: "Account Details"
                                        //                         .text
                                        //                         .make(),
                                        //                     onPressed: () {}),
                                        //               ),
                                        //               Spacer(),
                                        //               Container(
                                        //                 width: context.width,
                                        //                 child: CupertinoButton(
                                        //                     child:
                                        //                         "Sell Medicine Details"
                                        //                             .text
                                        //                             .make(),
                                        //                     onPressed: () {}),
                                        //               ),
                                        //               Spacer(),
                                        //               Container(
                                        //                 width: context.width,
                                        //                 child: CupertinoButton(
                                        //                     child: "Send Message"
                                        //                         .text
                                        //                         .make(),
                                        //                     onPressed: () {}),
                                        //               ),
                                        //               Spacer(),
                                        //               Container(
                                        //                 width: context.width,
                                        //                 child: CupertinoButton(
                                        //                     child: "Cancel"
                                        //                         .text
                                        //                         .color(Colors.red)
                                        //                         .make(),
                                        //                     onPressed: () {
                                        //                       back(context);
                                        //                     }),
                                        //               ),
                                        //               Spacer(),
                                        //             ],
                                        //           ),
                                        //         ),
                                        //       );
                                        //     });
                                      },
                                      icon: Icon(Icons.more_vert)),
                                ],
                              )
                            ]),
                          ),
                        );
                      }),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
