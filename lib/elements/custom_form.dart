import 'package:flutter/material.dart';

class MyCustomForm extends StatelessWidget {
  final bool isSecured;
  final Icon icon;
  final String hintText;
  final String? labelText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const MyCustomForm({
    required this.isSecured,
    required this.icon,
    required this.hintText,
    this.labelText,
    this.controller,
    super.key,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      validator: validator,
      obscureText: isSecured,
      obscuringCharacter: '*',
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        hintText: hintText,
        prefixIcon: icon,
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
