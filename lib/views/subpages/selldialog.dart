import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:smartcredit/controller/MainController.dart';
import 'package:smartcredit/navigator.dart';
import 'package:smartcredit/views/subpages/main.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../services/HttpService.dart';

class SellMedicineDialog extends StatefulWidget {
  @override
  _SellMedicineDialogState createState() => _SellMedicineDialogState();
}

class _SellMedicineDialogState extends State<SellMedicineDialog> {
  TextEditingController dateController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController sellPriceController = TextEditingController();
  String? selectedDoctor;
  String? selectedMedicine;
  String? selectedType;
  var medid;
  var docid;
  var type;

  List<String> types = ['Sell', 'Gift'];
  List doctors = [];
  List meds = [];
  GlobalKey<FormFieldState> productlistddlKey = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> productlistddlKey1 = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> productlistddlKey2 = GlobalKey<FormFieldState>();

  GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    getuser();
    getmeds();
    super.initState();
  }

  getuser() async {
    var value = jsonDecode(await HttpService.get(tabel: "doctor", query: null));

    doctors = value;
    setState(() {});
    print(value);
  }

  getmeds() async {
    var value =
        jsonDecode(await HttpService.get(tabel: "medicine", query: null));
    meds = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: SingleChildScrollView(
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDatePicker('Date'),
              SizedBox(height: 16.0),
              DropdownButtonFormField(
                  key: productlistddlKey,
                  isExpanded: true,
                  value: docid,
                  decoration: InputDecoration(
                      hintText: "Select Doctor", border: OutlineInputBorder()),
                  items: doctors
                      .map((element) => DropdownMenuItem(
                          value: element["id"],
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(element["image"]),
                              ),
                              6.widthBox,
                              Text(element['name']),
                            ],
                          )))
                      .toList(),
                  onChanged: (v) {
                    print(v);
                    //  Map<String, dynamic>? myObject = v as Map<String, dynamic>?;
                    docid = int.parse(v.toString());
                  }),
              SizedBox(height: 16.0),
              DropdownButtonFormField(
                  isExpanded: true,
                  key: productlistddlKey1,
                  value: medid,
                  decoration: InputDecoration(
                      hintText: "Select Medicine",
                      border: OutlineInputBorder()),
                  items: meds
                      .map((element) => DropdownMenuItem(
                          value: element["id"],
                          child: Row(
                            children: [
                              CircleAvatar(
                                child: Icon(Icons.medication_outlined),
                              ),
                              6.widthBox,
                              Text(element['medicineName']),
                            ],
                          )))
                      .toList(),
                  onChanged: (v) {
                    print(v);
                    //  Map<String, dynamic>? myObject = v as Map<String, dynamic>?;
                    medid = v;
                    print(medid);
                  }),
              const SizedBox(height: 16.0),
              buildDropdown('Type', types, (value) {
                setState(() {
                  selectedType = value;
                });
              }),
              const SizedBox(height: 16.0),
              buildInputField('Quantity', quantityController),
              const SizedBox(height: 16.0),
              buildInputField('Sell Price', sellPriceController),
              const SizedBox(height: 24.0),
              const Text(
                "Sign",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              Container(
                height: 100,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20)),
                child: SfSignaturePad(
                  key: _signaturePadKey,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      // ui.Image images =
                      //     await _signaturePadKey.currentState!.toImage();
                      // if (await _signaturePadKey.currentState!.toImage() ==
                      //     null) {

                      // Do something with the image file (e.g., display, upload, etc.)

                      // Delete the file after using it
                      // await tempFile.delete();

                      // }
                      if (dateController.text.isEmptyOrNull ||
                          quantityController.text.isEmptyOrNull ||
                          sellPriceController.text.isEmptyOrNull ||
                          medid == null ||
                          docid == null ||
                          type == null) {
                        print("objecat");
                      } else {
                        print("object");
                        postsell();
                      }
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    child: Text('Sell', style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (dateController.text.isEmptyOrNull ||
                          quantityController.text.isEmptyOrNull ||
                          sellPriceController.text.isEmptyOrNull ||
                          medid == null ||
                          docid == null ||
                          type == null) {
                      } else {
                        await postsellmore();
                        medid = null;
                        docid = null;
                        type = null;
                        productlistddlKey1.currentState!.reset();

                        productlistddlKey2.currentState!.reset();
                        productlistddlKey.currentState!.reset();
                        // setState(() {});
                      }
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    child: const Text('Sell More',
                        style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    child: const Text('Close',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDatePicker(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        SizedBox(height: 8.0),
        GestureDetector(
          onTap: () async {
            DateTime? selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (selectedDate != null) {
              dateController.text = selectedDate.toString();
            }
          },
          child: AbsorbPointer(
            child: TextField(
              controller: dateController,
              style: TextStyle(fontSize: 16.0),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Select Date',
                contentPadding: EdgeInsets.all(12.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildInputField(String label, TextEditingController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        SizedBox(height: 8.0),
        TextField(
          controller: TextEditingController,
          keyboardType: TextInputType.number,
          style: TextStyle(fontSize: 16.0),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter $label',
            contentPadding: EdgeInsets.all(12.0),
          ),
        ),
      ],
    );
  }

  Widget buildDropdown(
      String label, List<String> items, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        SizedBox(height: 8.0),
        DropdownButtonFormField(
          key: productlistddlKey2,
          value: type,
          items: items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: (v) {
            type = v.toString();
          },
          style: TextStyle(color: Colors.black, fontSize: 16.0),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Select $label',
            contentPadding: EdgeInsets.all(12.0),
          ),
        ),
      ],
    );
  }

  Future<void> postsell() async {
    print("object");
    back(context);

    final data = await _signaturePadKey.currentState!.toImage(pixelRatio: 3.0);

    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File tempFile = File('$tempPath/temp_image.png');

    List<int> pngBytes = bytes!.buffer.asUint8List();
    await tempFile.writeAsBytes(pngBytes);

    var a = double.parse(quantityController.text) *
        double.parse(sellPriceController.text);

    Map<String, String> query = {
      "transactionDate": dateController.text,
      "medicine": medid.toString(),
      "doctor": docid.toString(),
      "type": type,
      "quantity": quantityController.text,
      "sellPrice": sellPriceController.text,
      "totalPrice": a.toString()
    };

    http.StreamedResponse response = await HttpService.postdoc(
        tabel: "sell/create", image: File(tempFile.path), query: query);

    if (response.statusCode == 200) {
      var b = Get.put(MainController());
      b.sell = [];
      b.getsell();

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.green, content: Text("Added")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red, content: Text("Error")));
    }
  }

  Future<void> postsellmore() async {
    // back(context);

    final data = await _signaturePadKey.currentState!.toImage(pixelRatio: 3.0);

    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File tempFile = File('$tempPath/temp_image.png');

    List<int> pngBytes = bytes!.buffer.asUint8List();
    await tempFile.writeAsBytes(pngBytes);

    var a = double.parse(quantityController.text) *
        double.parse(sellPriceController.text);

    Map<String, String> query = {
      "transactionDate": dateController.text,
      "medicine": medid.toString(),
      "doctor": docid.toString(),
      "type": type,
      "quantity": quantityController.text,
      "sellPrice": sellPriceController.text,
      "totalPrice": a.toString()
    };

    http.StreamedResponse response = await HttpService.postdoc(
        tabel: "sell/create", image: File(tempFile.path), query: query);

    if (response.statusCode == 200) {
      var b = Get.put(MainController());
      b.sell = [];
      b.getsell();

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.green, content: Text("Added")));
      //// productlistddlKey.currentState!.reset();
      dateController.clear();
      //  docid = null;
      // productlistddlKey1.currentState!.reset();
      // medid = null;
      //  type = null;
      quantityController.clear();
      // productlistddlKey2.currentState!.reset();
      sellPriceController.clear();

      _signaturePadKey.currentState!.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(backgroundColor: Colors.red, content: Text("Error")));
    }
  }
}
