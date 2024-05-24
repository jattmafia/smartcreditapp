import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartcredit/controller/DataController.dart';
import 'package:smartcredit/navigator.dart';
import 'package:smartcredit/services/HttpService.dart';
import 'package:smartcredit/utils.dart';
import 'package:http/http.dart' as http;

class AddController extends GetxController {
  final doctorImage = Rxn<XFile>();
  final mrList = <dynamic>[].obs;
  final isLoading = false.obs;
  final selectedUser = Rxn<dynamic>();
  Position? position;

  loadMrs(BuildContext context) async {
    isLoading(true);
    showLoading(context);
    var value = jsonDecode(await HttpService.get(tabel: "users", query: null));
    print(value);
    mrList(value);
    isLoading(false);
    back(context);
  }

  picklocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  addRepresentative(
    BuildContext context,
    DataController controller, {
    required String name,
    required String username,
    required String phone,
    required String address,
    required String password,
  }) async {
    showLoading(context);
    var query = {
      "name": name,
      "username": username,
      "phone": phone,
      "password": password,
      "address": address,
    };
    var data =
        jsonDecode(await HttpService.get(tabel: "users/Create", query: query));
    if (data['code'] == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text("Representative Added")));
      controller.load();
      back(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(data['message'].toString())));
      print(data['message'].toString());
    }
    back(context);
  }

  void addDoctor(String name, String address, String phone,
      BuildContext context, DataController controller) async {
    showLoading(context);
    // List<int> imageBytes = await doctorImage.value!.readAsBytes();
    // print(imageBytes);
    // String base64Image = base64Encode(imageBytes);

    File image = File(doctorImage.value!.path);

    Map<String, String> query = {
      "name": name,
      "phone": phone,
      "dc_code": "DC11111",
      "address": address,
      "mr_name": selectedUser.value['name'],
      "mr_code": selectedUser.value['id'].toString(),
      "latitude": position!.latitude.toString(),
      "longitude": position!.longitude.toString()
    };

    print(query);
    http.StreamedResponse data =
        await HttpService.postdoc(tabel: "doctor", query: query, image: image);

    var resposne = await data.stream.bytesToString();
    print(resposne.toString());

    if (data.statusCode == 200) {
      back(context);
      back(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green, content: Text("Doctor Added")));
      controller.loadData("doctor");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red, content: Text(resposne.toString())));
      // print(data['message'].toString());
      back(context);
    }
  }
}
