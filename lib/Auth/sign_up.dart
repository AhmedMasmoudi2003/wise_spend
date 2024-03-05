// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import 'package:wise_spend/components/custom_text_field.dart';
import 'package:wise_spend/components/custom_password_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool obscure1 = true;
  bool obscure2 = true;
  TextEditingController? passwordController;
  TextEditingController? passwordController2;
  TextEditingController? mailController;
  TextEditingController? usernameController;

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
                    "Sign up",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text("Create an account to continue using the app",
                      style: TextStyle(fontSize: 14, color: Colors.grey[500])),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    mailController: mailController,
                    icon: Icon(Icons.person),
                    labelText: "UserName",
                    hintText: "Enter your Username",
                  ),
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
                      passwordController: passwordController,
                      icon: Icon(Icons.lock),
                      labelText: "Password",
                      hintText: "Enter your password",
                      obscure: obscure1),
                  SizedBox(
                    height: 20,
                  ),
                  CustomPasswordField(
                      passwordController: passwordController2,
                      icon: Icon(Icons.lock),
                      labelText: "Confirm Password",
                      hintText: "Confirm your password",
                      obscure: obscure2),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                onPressed: () {},
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                color: Colors.deepPurple,
                textColor: Colors.white,
                child: const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "have an account?",
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'login');
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 14, color: Colors.deepPurple),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
