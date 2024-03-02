import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import "package:wise_spend/transaction.dart";
import 'dart:convert'; // For jsonEncode and jsonDecode
import 'dart:async'; // For future and getApplicationDocumentsDirectory

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> tabsNames = [
    'All',
    'Income',
    'Expenses',
    'Savings',
    // 'Daily'
  ];
  // Future<List<Map<String, dynamic>>> viewsTab;
  // Future<List<Map<String, dynamic>>> viewsTabIncome = [{}];
  // Future<List<Map<String, dynamic>>> viewsTabExpenses = [];
  // Future<List<Map<String, dynamic>>> viewsTabSavings = [];

  // void splitViewsTab() {
  //   // fileToMap();
  //   readJson();
  //   for (var x in viewsTab) {
  //     if (x['type'] == "income") {
  //       viewsTabIncome.add(x);
  //     } else if (x['type'] == "expense") {
  //       viewsTabExpenses.add(x);
  //     } else {
  //       viewsTabSavings.add(x);
  //     }
  //   }
  // }

//   Future<void> mapToFile() async {
//     // Get the documents directory
//     final appDocDir = await getApplicationDocumentsDirectory();
// // Create a file path
//     final filePath = "${appDocDir.path}/data.json";
// // Open the file in write mode and encode the map
//     final file = File(filePath);
//     await file.writeAsString(jsonEncode(viewsTab));
//   }

  // Future<void> fileToMap() async {
  //   // Get the documents directory
  //   try {
  //     final appDocDir = await getApplicationDocumentsDirectory();
  //     final filePath = "${appDocDir.path}/data.bin";
  //     final file = File(filePath);
  //     // Open the file in read mode
  //     final data = await file.readAsString();
  //     // Decode the string back into a map
  //     final decodedMap =
  //         (jsonDecode(data) as List).cast<Map<String, dynamic>>();
  //     viewsTab = decodedMap;
  //   } catch (e) {
  //     if (e is PathNotFoundException) {
  //       viewsTab = [];
  //     } else {
  //       print('Error writing to file: $e');
  //     }
  //   }
  // }

  // Future<Map<String, dynamic>>? data;

  Future<List<dynamic>> readJson() async {
    final String response =
        await rootBundle.loadString('assets/transactions.json');
    final data = await json.decode(response);
    return data;
    // setState(() {
    //   viewsTab = data;
    //   print(viewsTab);
    // });
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

  // List<Widget> transactionsTab = [];

  // void addTransaction() {
  //   setState(() {
  //     var x = {
  //       'name': "NEWWWWWWW!",
  //       'type': "Savings",
  //       'amount': "15",
  //       'date': "28/02/2024",
  //       'category': "food",
  //     };
  // print(x.runtimeType);
  // viewsTab.add(x);
  // print(viewsTab);
  // if (x['type'] == "income") {
  //   viewsTabIncome.add(x);
  // } else if (x['type'] == "expense") {
  //   viewsTabExpenses.add(x);
  // } else {
  //   viewsTabSavings.add(x);
  // }
  // transactionsTab.insert(
  //     1,
  //     const Transaction(
  //       name: "NEWWWWWWW!",
  //       type: "Savings",
  //       amount: "15",
  //       date: "28/02/2024",
  //       category: "food",
  //     ));
  // mapToFile();
  // });
  // }

  // void createTransactionsTab() {
  //   transactionsTab.add(Card(
  //       child: Center(
  //           child: IconButton(
  //               icon: const Icon(Icons.add),
  //               onPressed: () => addTransaction()))));
  //   for (var x in viewsTab) {
  //     transactionsTab.add(Transaction(
  //       amount: x['amount'] ?? '',
  //       type: x['type'] ?? '',
  //       date: x['date'] ?? '',
  //       category: x['category'] ?? '',
  //       name: x['name'] ?? '',
  //     ));
  //   }
  // }

  // @override
  // initState() {
  //   super.initState();
  //   Future<Map<String, dynamic>> dataLoaded = readJson();
  //   // fileToMap();
  //   // splitViewsTab();
  //   // createTransactionsTab();
  // }

  //The UI here!!!!------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Center(child: Text("Manage Transactions")),
            ),
            //-------------------------------------------------------
            //----------------------------------------------------------------
            //----------------------------------------------------------------
            body: Center(
              child: Column(children: [
                // const Text(
                //   "See the history of the transactions..",
                // ),
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
                    Container(
                        // child: ListView.builder(
                        //   itemCount: viewsTabIncome.length,
                        //   itemBuilder: (BuildContext context, int index) {
                        //     return Transaction(
                        //       name: viewsTabIncome[index]['name'] ?? '',
                        //       type: viewsTabIncome[index]['type'] ?? '',
                        //       amount: viewsTabIncome[index]['amount'] ?? '',
                        //       date: viewsTabIncome[index]['date'] ?? '',
                        //       category: viewsTabIncome[index]['category'] ?? '',
                        //     );
                        //   },
                        // ),
                        ),
                    Container(
                        // child: ListView.builder(
                        //   itemCount: viewsTabExpenses.length,
                        //   itemBuilder: (BuildContext context, int index) {
                        //     return Transaction(
                        //       name: viewsTabExpenses[index]['name'] ?? '',
                        //       type: viewsTabExpenses[index]['type'] ?? '',
                        //       amount: viewsTabExpenses[index]['amount'] ?? '',
                        //       date: viewsTabExpenses[index]['date'] ?? '',
                        //       category: viewsTabExpenses[index]['category'] ?? '',
                        //     );
                        //   },
                        // ),
                        ),
                    Container(
                        // child: ListView.builder(
                        //   itemCount: viewsTabSavings.length,
                        //   itemBuilder: (BuildContext context, int index) {
                        //     return Transaction(
                        //       name: viewsTabSavings[index]['name'] ?? '',
                        //       type: viewsTabSavings[index]['type'] ?? '',
                        //       amount: viewsTabSavings[index]['amount'] ?? '',
                        //       date: viewsTabSavings[index]['date'] ?? '',
                        //       category: viewsTabSavings[index]['category'] ?? '',
                        //     );
                        //   },
                        // ),
                        ),
                  ]),
                ),
              ]),
            ),
            //-------------------------------------------------------
            //----------------------------------------------------------------
            //----------------------------------------------------------------
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
