import 'package:flutter/material.dart';

class MedicineDetailsDialog extends StatelessWidget {
  final Map<String, dynamic> medicineData;

  MedicineDetailsDialog({required this.medicineData});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Medicine Details'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          buildDetail('Medicine Name', medicineData['medicineName']),
          buildDetail('Medicine Unit', medicineData['medicineUnit']),
          buildDetail('Retail Price', '\$${medicineData['retailPrice']}'),
          buildDetail('Sell Price', '\$${medicineData['sellPrice']}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Close'),
        ),
      ],
    );
  }

  Widget buildDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
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
          title: Text('Medicine Details Dialog'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return MedicineDetailsDialog(
                    medicineData: {
                      "createdAt": 1703844730380,
                      "updatedAt": 1703844730380,
                      "id": 1,
                      "medicineName": "dd",
                      "medicineUnit": "Ml.",
                      "retailPrice": 12222,
                      "sellPrice": 11,
                    },
                  );
                },
              );
            },
            child: Text('Show Medicine Details Dialog'),
          ),
        ),
      ),
    );
  }
}
