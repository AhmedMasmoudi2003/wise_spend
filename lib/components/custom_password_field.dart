import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  const CustomPasswordField(
      {super.key,
      this.passwordController,
      required this.icon,
      required this.labelText,
      required this.hintText,
      required this.obscure});

  final TextEditingController? passwordController;
  final Icon icon;
  final String labelText;
  final String hintText;
  final bool obscure;

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool obscureText = false;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscure;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: widget.passwordController,
      decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          prefixIcon: widget.icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              icon:
                  Icon(obscureText ? Icons.visibility_off : Icons.visibility))),
    );
  }
}
