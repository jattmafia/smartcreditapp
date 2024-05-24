import 'package:flutter/cupertino.dart';
import 'package:smartcredit/views/data.dart';
import 'package:velocity_x/velocity_x.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  @override
  Widget build(BuildContext context) {
    return DataViewerWidget(
      table: "doctor",
      title: "Doctors",
      subtitleField: "phone",
      id: 1,
    );
  }
}
