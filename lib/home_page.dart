import "package:flutter/material.dart";

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
    'All',
    'Income',
    'Expenses'
  ];
  List<String> viewsTab = [
    "Hello",
    "World",
    "how",
    "are",
    "you",
    "Hello",
    "World"
  ];

  //The UI here!!!!------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 7,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              // title: Text(widget.title),
            ),
            //-------------------------------------------------------
            //----------------------------------------------------------------
            //----------------------------------------------------------------
            body: Center(
              child: Column(children: [
                const Text(
                  "Manage Transactions",
                ),
                TabBar(
                  isScrollable: true,
                  tabs: [for (var x in tabsNames) Tab(text: x)],
                ),
                Expanded(
                  child: TabBarView(children: [
                    for (var x in viewsTab) Text(x),
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
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.business),
                  label: 'Business',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.school),
                  label: 'test',
                ),
              ],
            )));
  }
}
