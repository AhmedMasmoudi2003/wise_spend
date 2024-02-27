import 'package:flutter/material.dart';

class Transaction extends StatelessWidget {
  final String type;
  final String amount;
  final String date;
  final String category;

  const Transaction(
      {super.key,
      required this.type,
      required this.amount,
      required this.date,
      required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: const Icon(Icons.money),
      title: Text(type),
      subtitle: Text(date),
      trailing: Text(amount),
    ));
  }
}
