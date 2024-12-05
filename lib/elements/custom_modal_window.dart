import 'package:flutter/material.dart';

class MyModalWindow extends StatelessWidget {
  final String title;
  final String content;
  final String answer;

  const MyModalWindow({
    required this.title,
    required this.content,
    required this.answer,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'Hi'),
              child: Text(answer),
            ),
          ],
        ),
      ),
    );
  }
}
