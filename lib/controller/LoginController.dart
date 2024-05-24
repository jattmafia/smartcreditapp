import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcredit/config.dart';
import 'package:smartcredit/models/User.dart';
import 'package:smartcredit/navigator.dart';
import 'package:smartcredit/services/HttpService.dart';
import 'package:smartcredit/views/home.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginController extends GetxController {
  final isPassword = true.obs;
  final isLoading = false.obs;

  void login(BuildContext context,
      {required String email, required String password}) async {
    isLoading(true);
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        List<User> user = userFromJson(await HttpService.get(
            tabel: "users", query: {"username": email, "password": password}));
        if (user.first.username.isNotEmpty) {
          storage.write("user", user.first.toJson());
          storage.write("isLoggedIn", true);
          storage.write("id", user.first.id);
          replaceTo(context, HomeScreen());
        }
        print(user.toString());
      } catch (e) {
        print("Error:  " + e.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: "Invalid Email/Password".text.white.make()));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: "Email/Password is required".text.white.make()));
    }
    isLoading(false);
  }
}
