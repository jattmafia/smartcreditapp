import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartcredit/config.dart';
import 'package:smartcredit/navigator.dart';
import 'package:smartcredit/views/home.dart';
import 'package:smartcredit/views/login.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() async {
    storage.writeIfNull("isLoggedIn", false);
    if (storage.read("isLoggedIn")) {
      await Future.delayed(Duration(seconds: 2));
      replaceTo(context, HomeScreen());
    } else {
      await Future.delayed(Duration(seconds: 2));
      replaceTo(context, LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade700,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: "logo",
              child: Image.asset(
                "assets/img/logo.png",
                height: 100,
              ),
            ),
            CupertinoActivityIndicator(
              radius: 15,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
