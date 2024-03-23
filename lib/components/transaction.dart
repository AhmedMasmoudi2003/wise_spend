import 'package:flutter/material.dart';
// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Transaction extends StatelessWidget {
  final String name;
  final String type;
  final String amount;
  final String date;
  final String category;

  const Transaction({
    super.key,
    required this.name,
    required this.type,
    required this.amount,
    required this.date,
    required this.category,
  });

  Icon setIcon() {
    if (type == "expense") {
      return const Icon(Icons.arrow_circle_up_rounded, color: Colors.red);
    } else {
      return const Icon(Icons.arrow_circle_down_rounded, color: Colors.green);
    }
  }

  @override
  Widget build(BuildContext context) {
    // CollectionReference transactions = FirebaseFirestore.instance.collection('transactions');

    // Future<void> addTransaction() {
    //   // Call the user's CollectionReference to add a new user
    //   return transactions
    //       .add({
    //         'name': name, // John Doe
    //         'type': type, // Stokes and Sons
    //         'amount': amount, // 42
    //         'date': date, // Stokes and Sons
    //         'category': category,
    //       })
    //       .then((value) => print("Transaction Added"))
    //       .catchError((error) => print("Failed to add transaction: $error"));
    // }

    return Card(
        child: ListTile(
      leading: setIcon(),
      title: Text(name),
      subtitle: Text(date),
      trailing: Text("${amount}TND"),
    ));
  }
}
