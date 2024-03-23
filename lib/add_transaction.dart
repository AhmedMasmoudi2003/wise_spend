// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wise_spend/components/custom_text_field.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  TextEditingController name = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController category = TextEditingController();

  CollectionReference transaction =
      FirebaseFirestore.instance.collection('transaction');

  Future<void> addTransaction() {
    // Call the user's CollectionReference to add a new user
    return transaction
        .add({
          'name': name.text, // John Doe
          'type': type.text, // Stokes and Sons
          'amount': amount.text, // 42
          'date': date.text, // Stokes and Sons
          'category': category.text,
        })
        .then((value) => print("transaction Added"))
        .catchError((error) => print("Failed to add transaction: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new transaction"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Create a new transaction",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple),
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                labelText: "name",
                hintText: "enter transaction name..",
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                labelText: "type",
                hintText: "enter transaction type..",
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                labelText: "amount",
                hintText: "enter transaction amount..",
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                labelText: "date",
                hintText: "enter transaction date..",
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                labelText: "category",
                hintText: "enter transaction category..",
              ),
              SizedBox(
                height: 15,
              ),
              MaterialButton(
                onPressed: addTransaction,
                color: Colors.purple,
                textColor: Colors.white,
                child: Text("Confirm Transaction"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
