import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcredit/services/HttpService.dart';

class DataController extends GetxController {
  final data = <dynamic>[].obs;
  final columns = <String>[].obs;
  final isLoading = false.obs;
  List user = [];
  onInit() {
    loadData("doctor");
    load();
  }

  loadData(String table, {dynamic query}) async {
    isLoading(true);
    update();

    try {
      var query = {"sort": "id DESC"};
      Future.delayed(const Duration(seconds: 2), () async {
        var res = jsonDecode(await HttpService.get(tabel: table, query: query));
        // for (var i in res[0].keys) {
        //   print("${i} : " + "${res[0][i] is Map<String, dynamic>}");
        //   print("${i} : " + "${res[0][i] is List<dynamic>}");
        //   if ((res[0][i] is Map<String, dynamic>) ||
        //       (res[0][i] is List<dynamic>)) {
        //   } else {
        //     columns.add(i);
        //   }
        // }
        // columns.remove("createdAt");
        // columns.remove("updatedAt");
        // columns.add("createdAt");
        // columns.add("updatedAt");

        // List b = res ["doctor"];
        columns.clear();
        data.clear();
        data(res);
        update();
      });

      // print(b);
      // data.forEach((element) => print(element[columns[0]]));
      // print(columns.value.toString());
    } catch (e) {
      print(e);
    }
    isLoading(false);
    update();
  }

  load() async {
    var res = await HttpService.getmeds(tabel: "user/all");

    var a = jsonDecode(res);

    user = a["user"];
    update();
    print(user);
  }
}
