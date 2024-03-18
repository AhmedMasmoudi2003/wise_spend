import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import "package:wise_spend/components/transaction.dart";
import 'dart:convert';
import 'dart:async';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  List<String> tabsNames = [
    'All',
    'Income',
    'Expenses',
    'Savings',
  ];

  Future<List<dynamic>> readJson() async {
    final String response =
        await rootBundle.loadString('assets/transactions.json');
    final data = await json.decode(response);
    return data;
  }

  Future<List<Map<String, dynamic>>> processData() async {
    List<dynamic> data = await readJson();
    List<Map<String, dynamic>> processedData = [];
    for (var x in data) {
      processedData.add({
        'name': x['name'],
        'type': x['type'],
        'amount': x['amount'],
        'date': x['date'],
        'category': x['category'],
      });
    }
    return processedData;
  }

  void addTransaction() {
    setState(() {
      var x = {
        'name': "NEWWWWWWW!",
        'type': "Savings",
        'amount': "15",
        'date': "28/02/2024",
        'category': "food",
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Center(child: Text("Manage Transactions")),
              actions: [
                IconButton(
                  icon: const Icon(Icons.exit_to_app),
                  onPressed: () async {
                    GoogleSignIn googleSignIn = GoogleSignIn();
                    try {
                      await googleSignIn.disconnect();
                      // Handle successful disconnection
                    } on PlatformException catch (error) {
                      print("Failed to disconnect: $error");
                      // Handle the error appropriately (e.g., display a user-friendly message)
                    }
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('login', (route) => false);
                  },
                ),
              ],
            ),
            body: Center(
              child: Column(children: [
                TabBar(
                  isScrollable: true,
                  tabs: [for (var x in tabsNames) Tab(text: x)],
                ),
                Expanded(
                  child: TabBarView(children: [
                    Column(
                      children: [
                        Card(
                            child: Center(
                                child: IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () => addTransaction()))),
                        Expanded(
                          child: FutureBuilder<List<Map<String, dynamic>>>(
                              future: processData(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return ListView.builder(
                                    itemCount: snapshot.data!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Transaction(
                                        name: snapshot.data![index]['name']!,
                                        type: snapshot.data![index]['type']!,
                                        amount: snapshot.data![index]['amount'],
                                        date: snapshot.data![index]['date']!,
                                        category: snapshot.data![index]
                                            ['category']!,
                                      );
                                    },
                                  );
                                }
                                return const Text('Something went wrong');
                              }),
                        )
                      ],
                    ),
                    Container(),
                    Container(),
                    Container(),
                  ]),
                ),
              ]),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.list_alt),
                  label: 'Transactions',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart),
                  label: 'Stats',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.signpost),
                  label: 'Goals',
                ),
              ],
            )));
  }
}
