import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcredit/config.dart';
import 'package:smartcredit/controller/LoginController.dart';
import 'package:smartcredit/navigator.dart';
import 'package:smartcredit/views/home.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  final _loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue.shade700,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: context.screenHeight * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    50.heightBox,
                    Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: "Login"
                            .text
                            .size(30)
                            .bold
                            .white
                            .align(TextAlign.start)
                            .make()),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: "Welcome back to $APP_NAME"
                          .text
                          .white
                          .align(TextAlign.start)
                          .make(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Container(
                  height: context.screenHeight * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Spacer(),
                      Center(
                        child: Hero(
                          tag: "logo",
                          child: Image.asset(
                            "assets/img/logo.png",
                            height: 100,
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          controller: email,
                          decoration: InputDecoration(
                              labelText: "Username",
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              prefixIcon: Icon(Icons.person)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Obx(() => TextField(
                              controller: password,
                              obscureText: _loginController.isPassword.value,
                              decoration: InputDecoration(
                                  labelText: "Password",
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  filled: true,
                                  suffix: GestureDetector(
                                      onTap: () {
                                        _loginController.isPassword(
                                            !_loginController.isPassword.value);
                                      },
                                      child: _loginController.isPassword.value
                                          ? "Show"
                                              .text
                                              .size(10)
                                              .color(Theme.of(context)
                                                  .primaryColor)
                                              .make()
                                          : "Hide"
                                              .text
                                              .size(10)
                                              .color(Theme.of(context)
                                                  .primaryColor)
                                              .make()),
                                  fillColor: Colors.grey.shade300,
                                  prefixIcon: Icon(Icons.lock)),
                            )),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        child: "Forget Password ?"
                            .text
                            .blue600
                            .bold
                            .align(TextAlign.left)
                            .make()
                            .onTap(() {
                          print("object");
                        }),
                      ),
                      50.heightBox,
                      Center(
                        child: Container(
                          width: context.screenWidth,
                          padding: EdgeInsets.all(16),
                          child: FilledButton(
                              style: ButtonStyle(
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)))),
                              onPressed: () {
                                _loginController.login(context,
                                    email: email.text, password: password.text);
                              },
                              child: Obx(() => _loginController.isLoading.value
                                  ? CupertinoActivityIndicator(
                                      color: Colors.white,
                                    ).p(13)
                                  : Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: "Login".text.make(),
                                    ))),
                        ),
                      ),
                      Spacer(),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
