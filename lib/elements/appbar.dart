import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isAbleGoBack;
  final String appTitle;
  final List<Widget>? actions;

  const MyAppBar({
    required this.isAbleGoBack,
    required this.appTitle,
    this.actions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: isAbleGoBack,
      centerTitle: true,
      actions: actions,
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Text(
        appTitle,
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
