import 'package:flutter/material.dart';

class TransactionDetailsDialog extends StatelessWidget {
  final Map<String, dynamic> transactionData;

  TransactionDetailsDialog({required this.transactionData});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Transaction Details'),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDetail('Transaction Date', formatDate(transactionData['transactionDate'])),
              buildDetail('Quantity', transactionData['quantity'].toString()),
              SizedBox(height: 16),
              buildDetail('Medicine Name', transactionData['medicine']['medicineName']),
              buildDetail('Medicine Unit', transactionData['medicine']['medicineUnit']),
              buildDetail('Retail Price', '\$${transactionData['medicine']['retailPrice']}'),
              buildDetail('Sell Price', '\$${transactionData['medicine']['sellPrice']}'),
              SizedBox(height: 16),
              buildDetail('Username', transactionData['user']['username']),
              buildDetail('User Name', transactionData['user']['name']),
              buildDetail('Phone', transactionData['user']['phone']),
            ],
          ),
        ),
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
             // color: Theme.of(context).primaryColor,
            ),
          ),
          Text(value),
        ],
      ),
    );
  }

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return "${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}";
  }
}
