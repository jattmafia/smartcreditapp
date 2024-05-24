import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smartcredit/navigator.dart';
import 'package:smartcredit/services/HttpService.dart';

class AddMedicineController extends GetxController {
  final formKey = GlobalKey<FormState>();
  bool addloading = false;

  TextEditingController name = TextEditingController();

  TextEditingController retailprice = TextEditingController();
  TextEditingController sellprice = TextEditingController();
  ScrollController? controller;
  List medicines = [];
  int currentpage = 1;
  List unit = ['Pc.', 'Ml.', 'Lt.'];
  int totalpage = 1;
  var medupdate = false;
  var medid;
  var selectedunit;
  var medindex;

  onInit() {
    getMedicine();
    controller = ScrollController()..addListener(handleScrolling);
    super.onInit();
  }

  void handleScrolling() {
    if (controller!.offset >= controller!.position.maxScrollExtent) {
      if (currentpage < totalpage) {
        currentpage++;
        getMedicine();
      }
    }
  }

  getMedicine() async {
    print(currentpage);

    var res = await HttpService.getmeds(
        tabel: "medicine/getAllMedicines?page=$currentpage");

    var response = jsonDecode(res);
    print(response);
    medicines = medicines + response["medicines"];

    totalpage = response["totalPages"];
    update();
  }

  addMedicine(BuildContext context) async {
    addloading = true;
    update();
    http.Response response = await HttpService.post(tabel: "medicine", query: {
      "medicineName": name.text,
      "medicineUnit": selectedunit.toString(),
      "retailPrice": retailprice.text,
      "sellPrice": sellprice.text
    });

    print(response.body);

    if (response.statusCode == 200) {
      print("b");
      medicines = [];
      getMedicine();

     // back(context);
      back(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green, content: Text("Medicine Added")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red, content: Text("Error")));
    }

    addloading = false;
    update();
  }

  deletemedicine(context, id, index) async {
    http.Response response =
        await HttpService.delete(tabel: "medicine/delete/${id.toString()}");

    print(response.body);

    if (response.statusCode == 200) {
      medicines.removeAt(index);
      update();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green, content: Text("Medicine Deleted")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("Error Something Went Wrong")));
    }
  }

  updatemedicine(context) async {
    http.Response response = await HttpService.update(
        tabel: "medicine/update/${medid.toString()}",
        query: {
          "medicineName": name.text,
          "medicineUnit": selectedunit.toString(),
          "retailPrice": retailprice.text,
          "sellPrice": sellprice.text
        });

    print(response.body);
    var b = jsonDecode(response.body);
    if (response.statusCode == 200) {
      //  medicines.removeAt(index);
      medicines[medindex] = b["updatedMedicine"];
      update();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green, content: Text("Medicine Updated")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("Error Something Went Wrong")));
    }
  }
}
