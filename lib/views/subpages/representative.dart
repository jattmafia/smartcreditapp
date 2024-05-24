import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcredit/controller/HomeController.dart';
import 'package:smartcredit/views/data.dart';

class RepresentativeScreen extends StatefulWidget {
  const RepresentativeScreen({super.key});

  @override
  State<RepresentativeScreen> createState() => _RepresentativeScreenState();
}

class _RepresentativeScreenState extends State<RepresentativeScreen> {
  final _homeController = Get.put(HomeController());
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await _homeController.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return DataViewerWidget(
      table: "users",
      title: "Representatives",
      id: 4,
      subtitleField: "phone",
    );
  }
}
