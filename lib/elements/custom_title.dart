import 'package:flutter/material.dart';

class MyTitleAndSubtitle extends StatelessWidget {
  final String mainTitle;
  final String subTitle;

  const MyTitleAndSubtitle({
    required this.mainTitle,
    required this.subTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          mainTitle,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          subTitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
