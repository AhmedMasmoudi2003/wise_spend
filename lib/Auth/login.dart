// ignore_for_file: prefer_const_constructors

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  TextEditingController passwordController = TextEditingController();
  TextEditingController mailController = TextEditingController();

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
                    textController: mailController,
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
                      obscure: obscure)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password?",
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
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
                onPressed: () async {
                  try {
                    final credential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: mailController.text,
                            password: passwordController.text);
                    if (credential.user!.emailVerified) {
                      Navigator.of(context)
                          .pushReplacementNamed('transactions');
                    } else {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.info,
                        animType: AnimType.rightSlide,
                        title: 'Verify your Email',
                        desc:
                            'A verification mail was sent, please verify your email to login',
                      ).show();
                    }
                  } on FirebaseAuthException {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      title: 'Error',
                      desc: 'error in email or password',
                    ).show();
                  }
                },
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                color: Colors.deepPurple,
                textColor: Colors.white,
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              height: 10,
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
                color: Colors.deepPurple[300],
                textColor: Colors.white,
                child: const Text(
                  "Login with Google",
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
                    "Don't have an account?",
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'signUp');
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 14, color: Colors.deepPurple),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
