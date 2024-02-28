import "dart:developer";

import "package:flutter/material.dart";
import "package:wise_spend/transaction.dart";

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
  List<Map<String, String>> viewsTab = [
    {
      'name': "Taxi",
      'type': "expense",
      'amount': "15",
      'date': "28/02/2024",
      'category': "food",
    },
    {
      'name': "test",
      'type': "income",
      'amount': "15",
      'date': "28/02/2024",
      'category': "food",
    },
    {
      'name': "cake",
      'type': "expense",
      'amount': "15",
      'date': "28/02/2024",
      'category': "food",
    },
    {
      'name': "sell article",
      'type': "income",
      'amount': "15",
      'date': "28/02/2024",
      'category': "food",
    },
    {
      'name': "win devfest",
      'type': "Savings",
      'amount': "15",
      'date': "28/02/2024",
      'category': "food",
    },
    {
      'name': "casque",
      'type': "Savings",
      'amount': "15",
      'date': "28/02/2024",
      'category': "food",
    },
    {
      'name': "printings",
      'type': "expense",
      'amount': "15",
      'date': "28/02/2024",
      'category': "food",
    }
  ];

  List<Map<String, String>> viewsTabIncome = [];
  List<Map<String, String>> viewsTabExpenses = [];
  List<Map<String, String>> viewsTabSavings = [];

  void splitViewsTab() {
    for (var x in viewsTab) {
      if (x['type'] == "income") {
        viewsTabIncome.add(x);
      } else if (x['type'] == "expense") {
        viewsTabExpenses.add(x);
      } else {
        viewsTabSavings.add(x);
      }
    }
  }

  List<Widget> transactionsTab = [];

  void createTransactionsTab() {
    transactionsTab.add(Card(
        child: Center(
            child: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => addTransaction()))));
    for (var x in viewsTab) {
      transactionsTab.add(Transaction(
        amount: x['amount'] ?? '',
        type: x['type'] ?? '',
        date: x['date'] ?? '',
        category: x['category'] ?? '',
        name: x['name'] ?? '',
      ));
    }
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
      viewsTab.add(x);
      if (x['type'] == "income") {
        viewsTabIncome.add(x);
      } else if (x['type'] == "expense") {
        viewsTabExpenses.add(x);
      } else {
        viewsTabSavings.add(x);
      }
      transactionsTab.add(const Transaction(
        name: "NEWWWWWWW!",
        type: "Savings",
        amount: "15",
        date: "28/02/2024",
        category: "food",
      ));
    });
  }

  @override
  initState() {
    super.initState();
    splitViewsTab();
    createTransactionsTab();
  }

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
                    Container(
                      child: ListView.builder(
                        itemCount: transactionsTab.length,
                        itemBuilder: (BuildContext context, int index) {
                          return transactionsTab[index];
                        },
                      ),
                    ),
                    Container(
                      child: ListView.builder(
                        itemCount: viewsTabIncome.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Transaction(
                            name: viewsTabIncome[index]['name'] ?? '',
                            type: viewsTabIncome[index]['type'] ?? '',
                            amount: viewsTabIncome[index]['amount'] ?? '',
                            date: viewsTabIncome[index]['date'] ?? '',
                            category: viewsTabIncome[index]['category'] ?? '',
                          );
                        },
                      ),
                    ),
                    Container(
                      child: ListView.builder(
                        itemCount: viewsTabExpenses.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Transaction(
                            name: viewsTabExpenses[index]['name'] ?? '',
                            type: viewsTabExpenses[index]['type'] ?? '',
                            amount: viewsTabExpenses[index]['amount'] ?? '',
                            date: viewsTabExpenses[index]['date'] ?? '',
                            category: viewsTabExpenses[index]['category'] ?? '',
                          );
                        },
                      ),
                    ),
                    Container(
                      child: ListView.builder(
                        itemCount: viewsTabSavings.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Transaction(
                            name: viewsTabSavings[index]['name'] ?? '',
                            type: viewsTabSavings[index]['type'] ?? '',
                            amount: viewsTabSavings[index]['amount'] ?? '',
                            date: viewsTabSavings[index]['date'] ?? '',
                            category: viewsTabSavings[index]['category'] ?? '',
                          );
                        },
                      ),
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
