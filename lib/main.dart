import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartcredit/config.dart';
import 'package:smartcredit/views/splash.dart';

void main() async {
  await GetStorage.init(APP_NAME);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: SplashScreen(),
    );
  }
}
