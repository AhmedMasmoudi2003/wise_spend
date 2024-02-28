import 'package:flutter/material.dart';

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
    return Card(
        child: ListTile(
      leading: setIcon(),
      title: Text(name),
      subtitle: Text(date),
      trailing: Text("${amount}TND"),
    ));
  }
}
