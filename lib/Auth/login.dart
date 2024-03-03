// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import 'package:wise_spend/components/custom_text_field.dart';
import 'package:wise_spend/components/custom_password_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool obscure = true;
  TextEditingController? passwordController;
  TextEditingController? mailController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        fit: BoxFit.cover,
                        "assets/images/official_logo.png",
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text("Login to continue using the app",
                      style: TextStyle(fontSize: 14, color: Colors.grey[500])),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    mailController: mailController,
                    icon: Icon(Icons.mail),
                    labelText: "Email",
                    hintText: "Enter your email",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomPasswordField(
                      icon: Icon(Icons.lock),
                      labelText: "Password",
                      hintText: "Enter your password",
                      obscure: obscure)
                ],
              ),
            ),
            MaterialButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'transactions');
                },
                child: Text("SignUp")),
          ],
        ),
      ),
    );
  }
}
