import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool isHome = true;
  bool isSearch = false;
  bool isFavourite = false;
  bool isProfile = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.home),
            isSelected: isHome,
            highlightColor: Theme.of(context).colorScheme.primary,
            onPressed: () => Navigator.pushNamed(context, '/'),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            isSelected: isSearch,
            highlightColor: Theme.of(context).colorScheme.primary,
            onPressed: () => Navigator.pushNamed(context, '/search'),
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            isSelected: isFavourite,
            highlightColor: Theme.of(context).colorScheme.primary,
            onPressed: () => Navigator.pushNamed(context, '/favourite'),
          ),
          IconButton(
            icon: const Icon(Icons.person),
            isSelected: isProfile,
            highlightColor: Theme.of(context).colorScheme.primary,
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
    );
  }
}
