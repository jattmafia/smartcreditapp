import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smartcredit/controller/MainController.dart';
import 'package:smartcredit/navigator.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../services/HttpService.dart';

class ReceiveMedicineDialog extends StatefulWidget {
  @override
  _ReceiveMedicineDialogState createState() => _ReceiveMedicineDialogState();
}

class _ReceiveMedicineDialogState extends State<ReceiveMedicineDialog> {
  TextEditingController dateController = TextEditingController();
  TextEditingController receivedamountController = TextEditingController();
  TextEditingController sellPriceController = TextEditingController();
  String? selectedDoctor;

  var docid;


  List doctors = [];


  @override
  void initState() {
    // TODO: implement initState
    getuser();
    super.initState();
  }

  getuser() async {
    var value = jsonDecode(await HttpService.get(tabel: "doctor", query: null));

    doctors = value;
    setState(() {});
    print(value);
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildDatePicker('Date'),
            SizedBox(height: 16.0),
            DropdownButtonFormField(
                isExpanded: true,
                //value: .selectedmed == null ? null : .selectedmed['id'],
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
            buildInputField('Received amount', receivedamountController),
            SizedBox(height: 16.0),
            buildInputField('Sell Price', sellPriceController),
            SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (dateController.text.isEmptyOrNull ||
                        receivedamountController.text.isEmptyOrNull ||
                        sellPriceController.text.isEmptyOrNull ||
                        docid == null 
                        ) {
                    } else {
                      postsell();
                    }
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  child: Text('Receive', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: Text('Close', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
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
       ],
    );
  }

  Future<void> postsell() async {
    back(context);
   
    http.Response response =
        await HttpService.post(tabel: "receive/create", query: {
      "receiveDate": dateController.text,
      "doctor": docid,
      "sellPrice": sellPriceController.text,
      "receivedAmount": sellPriceController.text
    });

    print(response.body);

    if (response.statusCode == 200) {
      print("b");

      var b = Get.put(MainController());
  
      b.receive =[];
      b.getreceive();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green, content: Text("Added")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red, content: Text("Error")));
    }
  }
}
