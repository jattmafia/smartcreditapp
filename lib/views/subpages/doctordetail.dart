import 'package:flutter/material.dart';

class DoctorDetailsDialog extends StatelessWidget {
  final Map<String, dynamic> doctorData;

  DoctorDetailsDialog({required this.doctorData});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(doctorData['image']),
        ),
        SizedBox(height: 16.0),
        Text(
          doctorData['name'],
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Text(
          doctorData['mr_name'],
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
        SizedBox(height: 16.0),
        buildDetail('Address', doctorData['address']),
        buildDetail('Phone', doctorData['phone']),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }

  Widget buildDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Doctor Details Dialog'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DoctorDetailsDialog(doctorData: {
                    "createdAt": 1703604666898,
                    "updatedAt": 1703604666898,
                    "id": 1,
                    "mr_name": "admin",
                    "name": "doctor 1",
                    "address": "demo",
                    "phone": "8787585854",
                    "image":
                        "http://10.0.2.2:1337/images/a5f89128-c7e5-4f23-adf6-d1b3c7575b84.jpg",
                    "is_active": 1,
                    "mr_code": {
                      "createdAt": 3332232,
                      "updatedAt": 322333,
                      "id": 1,
                      "name": "admin",
                      "username": "admin",
                      "phone": "8787878787",
                      "password": "123456",
                      "address": "demo",
                      "role": 1
                    }
                  });
                },
              );
            },
            child: Text('Show Doctor Details Dialog'),
          ),
        ),
      ),
    );
  }
}
