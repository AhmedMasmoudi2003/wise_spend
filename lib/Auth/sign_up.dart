// ignore_for_file: prefer_const_constructors, avoid_print
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address.';
    }

    // Regular expression for basic email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address.';
    }

    return null; // No error
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password.';
    }

    // Minimum length check
    if (value.length < 8) {
      return 'Password must be at least 8 characters long.';
    }

    // Character class checks
    bool hasUppercase = value.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = value.contains(RegExp(r'[a-z]'));
    bool hasNumbers = value.contains(RegExp(r'\d'));
    bool hasSymbols = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    // Password is weak if it lacks at least 3 character classes
    if (!hasUppercase || !hasLowercase || !hasNumbers && !hasSymbols) {
      return 'Password must be a mix of uppercase, lowercase, numbers, and symbols.';
    }

    return null; // No error
  }

  void showVerificationSnackbar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: Colors.green, // You can customize the background color
      ),
    );
  }

  void sendVerificationEmail() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      // Show success message
    } on FirebaseAuthException catch (e) {
      if (e.code == 'too-many-requests') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'You\'ve recently requested a verification email. Please check your inbox or wait a few minutes before requesting another one.'),
          ),
        );
      }
    }
  }

  final formKey = GlobalKey<FormState>();

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
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          textController: mailController,
                          validator: validateEmail,
                          icon: Icon(Icons.mail),
                          labelText: "Email",
                          hintText: "Enter your email",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomPasswordField(
                            validator: validatePassword,
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
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            onPressed: () async {
                              if (passwordController.text !=
                                  passwordController2.text) {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.rightSlide,
                                  title: 'Error',
                                  desc: 'Passwords do not match',
                                ).show();
                                return;
                              }
                              if (formKey.currentState!.validate()) {
                                print("valid");
                                try {
                                  final credential = await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                    email: mailController.text,
                                    password: passwordController.text,
                                  );
                                  sendVerificationEmail();
                                  showVerificationSnackbar(
                                      "A verification mail was sent, check your inbox.");
                                  Navigator.of(context)
                                      .pushReplacementNamed('login');
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'weak-password') {
                                    print('The password provided is too weak.');
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.error,
                                      animType: AnimType.rightSlide,
                                      title: 'Error',
                                      desc:
                                          'The password provided is too weak.',
                                    ).show();
                                  } else if (e.code == 'email-already-in-use') {
                                    print(
                                        'The account already exists for that email.');
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.error,
                                      animType: AnimType.rightSlide,
                                      title: 'Error',
                                      desc:
                                          'The account already exists for that email.',
                                    ).show();
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              }
                            },
                            padding: EdgeInsets.symmetric(
                                horizontal: 100, vertical: 10),
                            color: Colors.deepPurple,
                            textColor: Colors.white,
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
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
