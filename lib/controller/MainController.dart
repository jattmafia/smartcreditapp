import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import '../services/HttpService.dart';

class MainController extends GetxController {
  int currentpage = 1;
  int totalpage = 1;

  int receivecurrentpage = 1;
  int receivetotalpage = 1;

  int giftcurrentpage = 1;
  int gifttotalpage = 1;
  List sell = [];
  List gift = [];
  List receive = [];
  var totalprice = 0;


   ScrollController? sellcontroller;
    ScrollController? giftcontroller;
     ScrollController? receivecontroller;

  @override
  onInit() {
    getsell();
    getgift();
    getreceive();
     sellcontroller = ScrollController()..addListener(handlesellScrolling);
     giftcontroller = ScrollController()..addListener(handlegiftScrolling);
     receivecontroller = ScrollController()..addListener(handlereceiveScrolling);
    super.onInit();
  }


void handlesellScrolling() {
    if (sellcontroller!.offset >= sellcontroller!.position.maxScrollExtent) {
      if (currentpage < totalpage) {
        currentpage++;
        getsell();
      }
    }
}

void handlegiftScrolling() {
    if (giftcontroller!.offset >= giftcontroller!.position.maxScrollExtent) {
      if (giftcurrentpage < gifttotalpage) {
        giftcurrentpage++;
        getgift();
      }
    }
}


void handlereceiveScrolling() {
    if (receivecontroller!.offset >= receivecontroller!.position.maxScrollExtent) {
      if (receivecurrentpage < receivetotalpage) {
        receivecurrentpage++;
        getreceive();
      }
    }
}


  getreceive() async {
    totalprice = 0;
    var res = await HttpService.getmeds(tabel: "receive/all?page=$currentpage");

    var response = jsonDecode(res);
    print(response);
    receive = receive + response["receive"];
    totalpage = response["totalPages"];

    update();
  }

  getsell() async {
    totalprice = 0;
    var res = await HttpService.getmeds(tabel: "sell/all?page=$currentpage");

    var response = jsonDecode(res);
    print(response);
    sell = sell + response["sellTransactions"];
    totalpage = response["totalPages"];
    for (var i = 0; i < sell.length; i++) {
      var a = int.parse(sell[i]["totalPrice"].toString());
      totalprice = totalprice + a;
    }
    update();
  }

  getgift() async {
    totalprice = 0;
    var res =
        await HttpService.getmeds(tabel: "gift/all?page=$giftcurrentpage");

    var response = jsonDecode(res);

    print(response);
    gift = gift + response["sellTransactions"];
    gifttotalpage = response["totalPages"];

    update();
  }
}
