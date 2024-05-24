
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../services/HttpService.dart';

class DriverController extends GetxController {
  int currentpage = 1;
  int totalpage = 1;
  ScrollController? controller;
  List drivers = [];

  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  
  var selectedid;

  @override
  void onInit() {
    // TODO: implement onInit

    marker();
    getdriver();
    super.onInit();
  }

  marker () async {
    final Uint8List markericon = await getBytesFromAsset('assets/img/driver.png', 100);
   markerIcon =  BitmapDescriptor.fromBytes(markericon);

   update();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
}

  void handleScrolling() {
    if (controller!.offset >= controller!.position.maxScrollExtent) {
      if (currentpage < totalpage) {
        currentpage++;
        getdriver();
      }
    }
  }

  getdriver() async {
    print(currentpage);

    var res = await HttpService.getmeds(
        tabel: "driver/get?page=$currentpage");

    var response = jsonDecode(res);
    print(response);
    drivers = drivers + response["drivers"];

    totalpage = response["totalPages"];
    update();
  }
}
