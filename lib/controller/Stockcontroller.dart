import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smartcredit/navigator.dart';
import '../services/HttpService.dart';

class StockController extends GetxController {
  int? userid;
  int? medid;
  TextEditingController quantity = TextEditingController();
  bool addloading = false;
  final formKey = GlobalKey<FormState>();
  List users = [];
  List meds = [];
  List stock = [];
  int currentpage = 1;
  int totalpage = 1;
  ScrollController? controller;
  var selectedmed;
  var selecteduser;

  bool stockupdate = false;
  var stockindex;
  var stockid;
  @override
  void onInit() {
    // TODO: implement onInit
    getstock();
    getuser();
    getmeds();
    super.onInit();
  }

  getuser() async {
    var value = jsonDecode(await HttpService.get(tabel: "users", query: null));

    users = value;
  }

  getmeds() async {
    var value =
        jsonDecode(await HttpService.get(tabel: "medicine", query: null));
    meds = value;
  }

  getstock() async {
    var res = await HttpService.getmeds(tabel: "stock?page=$currentpage");

    var response = jsonDecode(res);
    print(response);
    stock = stock + response["stocks"];

    totalpage = response["totalPages"];
    print(stock.length);
    update();
  }

  adstock(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime today = now.toLocal();
    String dateString = today.toString().split(' ')[0];
    print(dateString);
    addloading = true;

    update();
    http.Response response =
        await HttpService.post(tabel: "stock/create", query: {
      "transactionDate": dateString,
      "medicine": medid,
      "user": userid,
      "quantity": quantity.text
    });
    print(response.body);
    if (response.statusCode == 200) {
      stock = [];
      getstock();
      back(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green, content: Text("Stock Added")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red, content: Text("Error")));
    }

    addloading = false;
    update();
  }


 deletestock(context,id,index) async {
     http.Response response = await HttpService.delete(tabel: "stock/delete/${id.toString()}");
    
    print(response.body);
     
     if(response.statusCode == 200){
       stock.removeAt(index);
      update();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text("Medicine Deleted")));

    
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("Error Something Went Wrong")));
      
    }
  }



  updatestock(context) async {
     http.Response response = await HttpService.update(tabel: "stock/update/${stockid.toString()}",query: {
      "medicine": medid,
      "user": userid,
      "quantity": quantity.text
    });
    
    print(response.body);
     var b = jsonDecode(response.body);
     if(response.statusCode == 200){
     stock = [];
     getstock();
      update();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text("Medicine Updated")));

    
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("Error Something Went Wrong")));
      
    }
  }


}
