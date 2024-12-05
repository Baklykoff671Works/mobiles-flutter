import 'package:flutter/material.dart';

class MyCustomButton extends StatelessWidget {
  final String buttonText;
  final Color textColor;
  final Color buttonColor;
  final VoidCallback functionPressed;

  const MyCustomButton({
    required this.buttonText,
    required this.textColor,
    required this.buttonColor,
    required this.functionPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: functionPressed,
      minWidth: double.infinity,
      height: 60,
      color: buttonColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
