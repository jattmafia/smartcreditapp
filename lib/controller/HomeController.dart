import 'dart:convert';

import 'package:get/get.dart';
import 'package:smartcredit/models/User.dart';
import 'package:smartcredit/services/HttpService.dart';

class HomeController extends GetxController {
  final users = <User>[].obs;
  final usersColumns = <String>[].obs;
  final isLoading = false.obs;

  getUsers() async {
    isLoading(true);
    users.clear;
    usersColumns.clear();
    try {
      List<User> usersss =
          await userFromJson(await HttpService.get(tabel: "users"));
      dynamic data = jsonDecode(userToJson(usersss));
      for (var key in data[0].keys) {
        usersColumns.add(key);
      }
      usersColumns.remove("createdAt");
      usersColumns.remove("updatedAt");

      usersColumns.add("createdAt");
      usersColumns.add("updatedAt");

      await Future.delayed(Duration(seconds: 1));
      users(usersss);
    } catch (e) {
      print(e);
    }
    isLoading(false);
  }
}
