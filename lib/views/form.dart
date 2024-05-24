import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:smartcredit/models/Field.dart';
import 'package:velocity_x/velocity_x.dart';

class FormAddEdit extends StatefulWidget {
  String table;
  String title;
  List<Field> fields;
  FormAddEdit(
      {super.key,
      required this.fields,
      required this.table,
      required this.title});

  @override
  State<FormAddEdit> createState() => _FormAddEditState();
}

class _FormAddEditState extends State<FormAddEdit> {
  Map<String, dynamic> formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.title.text.make(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var i = 0; i < widget.fields.length; i++)
              getFieldWidget(widget.fields[i]),
            Container(
                width: context.width * 0.9,
                margin: EdgeInsets.only(top: 20),
                child:
                    FilledButton(onPressed: () {}, child: Text("Submit").p(15)))
          ],
        ),
      ),
    );
  }

  Widget getFieldWidget(Field field) {
    switch (field.type) {
      case 'String':
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: InputDecoration(
                labelText: field.name.capitalized,
                border: OutlineInputBorder()),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter ${field.name}';
              }
              formData[field.name] = value;
              return null;
            },
          ),
        );
      case 'Image':
        // You can implement image picker here
        return Text('Image Picker Placeholder');
      case 'Dropdown':
        return DropdownButtonFormField(
          decoration: InputDecoration(labelText: field.name),
          items: field.options!
              .map((option) =>
                  DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
          onChanged: (value) {
            formData[field.name] = value;
          },
          validator: (value) {
            if (value == null) {
              return 'Please select ${field.name}';
            }
            return null;
          },
        );
      default:
        return SizedBox.shrink();
    }
  }
}
