import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcredit/controller/drivercontroller.dart';
import 'package:smartcredit/navigator.dart';
import 'package:smartcredit/views/drivers.dart';
import 'package:velocity_x/velocity_x.dart';

class AllDriver extends StatelessWidget {
  final controller = Get.put(DriverController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Drivers".text.make(),
      ),
      body: GetBuilder<DriverController>(builder: (_) {
        return SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: ListView.builder(
                    controller: controller.controller,
                    shrinkWrap: true,
                    itemCount: controller.drivers.length,
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: () {
                          if (controller.drivers[index]["isOnline"] == false) {
                            return;
                          } else {
                            controller.selectedid =
                                controller.drivers[index]["id"];
                            navigateTo(
                                context,
                                DriverScreen(
                                    lat: controller.drivers[index]["latitude"],
                                    long: controller.drivers[index]
                                        ["longitude"]));
                          }
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
                                backgroundImage: NetworkImage(
                                    controller.drivers[index]["image"]),
                              ),
                              10.widthBox,
                              GestureDetector(
                                onTap: () {},
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(controller.drivers[index]["email"]),
                                    Text(controller.drivers[index]["email"])
                                  ],
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                  onPressed: () {
                                    // controller.selectedid = controller.drivers[index]["id"];
                                    // navigateTo(context, DriverScreen());
                                  },
                                  icon: Icon(
                                    Icons.circle,
                                    color: controller.drivers[index]
                                                ["isOnline"] ==
                                            true
                                        ? Colors.green
                                        : Colors.red,
                                  ))
                            ]),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        );
      }),
    );
  }
}
