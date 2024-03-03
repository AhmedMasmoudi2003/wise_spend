import 'package:flutter/material.dart';
import 'package:wise_spend/transactions.dart';
import 'package:wise_spend/Auth/login.dart';
import 'package:wise_spend/Auth/sign_up.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: {
          'transactions': (context) => const Transactions(),
          'login': (context) => const Login(),
          'signUp': (context) => const SignUp(),
        });
  }
}
