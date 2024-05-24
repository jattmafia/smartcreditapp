import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:smartcredit/config.dart';
import 'package:smartcredit/controller/DataController.dart';
import 'package:smartcredit/controller/HomeController.dart';
import 'package:smartcredit/models/Field.dart';
import 'package:smartcredit/navigator.dart';
import 'package:smartcredit/views/add/AddDoctor.dart';
import 'package:smartcredit/views/add/AddRepresentative.dart';
import 'package:smartcredit/views/form.dart';
import 'package:smartcredit/views/subpages/doctordetail.dart';
import 'package:velocity_x/velocity_x.dart';

class DataViewerWidget extends StatefulWidget {
  String title;
  String table;
  String titleField;
  String subtitleField;
  bool isImage;
  String? imageField;
  int id;
  DataViewerWidget(
      {super.key,
      required this.id,
      required this.table,
      required this.title,
      this.titleField = "name",
      this.subtitleField = "email",
      this.isImage = false,
      this.imageField});

  @override
  State<DataViewerWidget> createState() => _DataViewerWidgetState();
}

class _DataViewerWidgetState extends State<DataViewerWidget> {
  final _dataController = Get.put(DataController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() async {
    await _dataController.loadData(widget.table);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        init();
      },
      child: GetBuilder<DataController>(builder: (_) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.title.text.bold.size(20).make(),
                FilledButton(
                    onPressed: () {
                      // List<String> form = [];
                      // form.addAll(_dataController.columns.value);
                      // form.remove("id");
                      // form.remove("createdAt");
                      // form.remove("updatedAt");
                      // navigateTo(
                      //     context,
                      //     FormAddEdit(
                      //         fields: form
                      //             .map((element) =>
                      //                 Field(name: element, type: "String"))
                      //             .toList(),
                      //         table: "users",
                      //         title: "Add Users"));
                      if (widget.id == 1) {
                        navigateTo(
                            context,
                            AddDoctor(
                              controller: _dataController,
                            ));
                      } else if (widget.id == 2) {
                        navigateTo(
                            context,
                            AddDoctor(
                              controller: _dataController,
                            ));
                      } else if (widget.id == 3) {
                        navigateTo(
                            context,
                            AddRepresentative(
                              controller: _dataController,
                            ));
                      } else if (widget.id == 4) {
                        navigateTo(
                            context,
                            AddRepresentative(
                              controller: _dataController,
                            ));
                      }
                    },
                    child: "Add New".text.make())
              ],
            ).p(20),
            // DropdownButton(items: [
            //   DropdownMenuItem(child: Text("Id"), value: "id"),
            // ], onChanged: (value) {}),

            Obx(
              () => _dataController.isLoading.value
                  ? Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : widget.id == 4
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: _dataController.user.length,
                          itemBuilder: (_, index) {
                            return Card(
                              elevation: 5,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Row(children: [
                                  CircleAvatar(
                                    // backgroundImage:
                                    //  widget.isImage
                                    // //     ?
                                    // NetworkImage(
                                    // _dataController.data[index]['image'])
                                    //     : null,
                                    // child: widget.isImage
                                    //     ? null
                                    //     :
                                    child: Text(
                                        _dataController.user[index]["name"][0]),
                                  ),
                                  10.widthBox,
                                  GestureDetector(
                                    onTap: () {
                                      // var b = _dataController.data[index];
                                      // showDialog(
                                      //   context: context,
                                      //   builder: (BuildContext context) {
                                      //     return DoctorDetailsDialog(doctorData: b);
                                      //   },
                                      // );
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(_dataController.user[index]
                                            ["name"]),
                                        Text(_dataController.user[index]
                                            ["phone"])
                                      ],
                                    ),
                                  ),
                                  Spacer(),
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
                                        //               borderRadius:
                                        //                   BorderRadius.only(
                                        //                       topLeft:
                                        //                           Radius.circular(
                                        //                               20),
                                        //                       topRight:
                                        //                           Radius.circular(
                                        //                               20)),
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
                                        //                     onPressed: () async {
                                        //                       print("object");
                                        //                       var number =
                                        //                           _dataController
                                        //                                       .data[
                                        //                                   index][
                                        //                               'phone']; //set the number here

                                        //                       await FlutterPhoneDirectCaller
                                        //                           .callNumber(
                                        //                               number);
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
                                      icon: Icon(Icons.more_vert))
                                ]),
                              ),
                            );
                          })
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: _dataController.data.length,
                          itemBuilder: (_, index) {
                            print(_dataController.data[index]);
                            return Card(
                              elevation: 5,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Row(children: [
                                  CircleAvatar(
                                      backgroundImage:
                                          //  widget.isImage
                                          //     ?
                                          NetworkImage(_dataController
                                              .data[index]['image'])
                                      //     : null,
                                      // child: widget.isImage
                                      //     ? null
                                      //     : Text(_dataController.data[index]
                                      //         [widget.titleField][0]),
                                      ),
                                  10.widthBox,
                                  GestureDetector(
                                    onTap: () {
                                      var b = _dataController.data[index];
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DoctorDetailsDialog(
                                              doctorData: b);
                                        },
                                      );
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(_dataController.data[index]
                                            [widget.titleField]),
                                        Text(_dataController.data[index]
                                            [widget.subtitleField])
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
                                                constraints: BoxConstraints(
                                                    maxHeight: 300),
                                                child: Container(
                                                  width: context.width,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(20),
                                                              topRight: Radius
                                                                  .circular(
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
                                                            child:
                                                                "Account Details"
                                                                    .text
                                                                    .make(),
                                                            onPressed: () {}),
                                                      ),
                                                      Spacer(),
                                                      Container(
                                                        width: context.width,
                                                        child: CupertinoButton(
                                                            child: "Direction"
                                                                .text
                                                                .make(),
                                                            onPressed:
                                                                () async {
                                                              await MapLauncher
                                                                  .showMarker(
                                                                mapType: MapType
                                                                    .google,
                                                                coords: Coords(
                                                                    _dataController
                                                                            .data[index]
                                                                        [
                                                                        "latitude"],
                                                                    _dataController
                                                                            .data[index]
                                                                        [
                                                                        "longitude"]),
                                                                title: _dataController
                                                                            .data[
                                                                        index][
                                                                    widget
                                                                        .titleField],
                                                              );
                                                            }),
                                                      ),
                                                      Spacer(),
                                                      Container(
                                                        width: context.width,
                                                        child: CupertinoButton(
                                                            child:
                                                                "Sell Medicine Details"
                                                                    .text
                                                                    .make(),
                                                            onPressed: () {}),
                                                      ),
                                                      Spacer(),
                                                      Container(
                                                        width: context.width,
                                                        child: CupertinoButton(
                                                            child:
                                                                "Send Message"
                                                                    .text
                                                                    .make(),
                                                            onPressed: () {}),
                                                      ),
                                                      Spacer(),
                                                      Container(
                                                        width: context.width,
                                                        child: CupertinoButton(
                                                            child: "Cancel"
                                                                .text
                                                                .color(
                                                                    Colors.red)
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

              // SingleChildScrollView(
              //     scrollDirection: Axis.vertical,
              //     child: SingleChildScrollView(
              //       scrollDirection: Axis.horizontal,
              // child: DataTable(
              //   columns: _dataController.columns
              //       .map((element) =>
              //           DataColumn(label: Text(element.capitalized)))
              //       .toList(),
              //   // ignore: avoid_function_literals_in_foreach_calls
              //   rows: _dataController.data
              //       .map((element) => DataRow(
              //           cells: _dataController.columns
              //               .map((em) => DataCell(
              //                   em.toString() == "createdAt" ||
              //                           em.toString() == "updatedAt"
              //                       ? Text(readTimestamp(element[em]))
              //                       : Text(element[em].toString())))
              //               .toList()))
              //       .toList(),
              // ),
              // ))
              //
            ),
            // 20.heightBox,
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Container(
            //       width: context.width * 0.15,
            //       child: Chip(label: Icon(Icons.arrow_left)),
            //     ),
            //     SizedBox(
            //       width: context.width * 0.65,
            //       child: SingleChildScrollView(
            //         scrollDirection: Axis.horizontal,
            //         child: Row(
            //           children: [
            //             for (var i = 0; i < 10; i++)
            //               Chip(
            //                 color: i == 1
            //                     ? MaterialStatePropertyAll(
            //                         Theme.of(context).primaryColor)
            //                     : null,
            //                 labelStyle:
            //                     i == 1 ? TextStyle(color: Colors.white) : null,
            //                 label: Text(i.toString()),
            //               ).p(2),
            //           ],
            //         ),
            //       ),
            //     ),
            //     Container(
            //         width: context.width * 0.15,
            //         child: Chip(label: Icon(Icons.arrow_right))),
            //   ],
            // ).p(10)
          ],
        );
      }),
    );
  }

  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var date = DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
    var diff = date.difference(now);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = DateTimeFormat.format(date, format: 'j/m/Y g:m a');
    } else {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + 'DAY AGO';
      } else {
        time = diff.inDays.toString() + 'DAYS AGO';
      }
    }

    return time;
  }
}
