import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.mailController,
      required this.icon,
      required this.labelText,
      required this.hintText});

  final TextEditingController? mailController;
  final Icon icon;
  final String labelText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: mailController,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: icon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
