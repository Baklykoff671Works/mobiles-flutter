import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test_project/data.dart';
import 'package:flutter_test_project/elements/appbar.dart';
import 'package:flutter_test_project/elements/navbar.dart';
import 'package:flutter_test_project/instances/art.dart';
import 'package:flutter_test_project/instances/user.dart';
import 'package:hive_flutter/adapters.dart';

class MyFavouritePage extends StatefulWidget {
  const MyFavouritePage({super.key});

  @override
  State<MyFavouritePage> createState() => _MyFavouritePageState();
}

class _MyFavouritePageState extends State<MyFavouritePage> {
  Future<bool> check() async {
    bool result = false;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('To be or not to be?'),
          content: const Text('Simple question, existential answer'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() => result = true);
                Navigator.pop(context);
              },
              child: const Text('To be'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Not to be'),
            ),
          ],
        );
      },
    );
    print(result);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        isAbleGoBack: false,
        appTitle: 'Favourites',
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0), // Add some padding for better spacing
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center buttons vertically
          crossAxisAlignment: CrossAxisAlignment.center, // Align buttons horizontally
          children: [
            TextButton(
              onPressed: check,
              child: const Text(
                'Open modal',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                textStyle: const TextStyle(decoration: TextDecoration.underline),
              ),
            ),
            const SizedBox(height: 16), // Add spacing between buttons
            ElevatedButton(
              onPressed: () async {
                if (!Hive.isAdapterRegistered(0)) {
                  Hive.registerAdapter(UserAdapter());
                }

                await Hive.initFlutter();

                final userBox = await Hive.openBox<User>('users');

                for (final key in userBox.keys) {
                  final user = userBox.get(key);
                  print(user);
                }
              },
              child: const Text('Check Storage'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white70,
                backgroundColor: Colors.black45, // Change button color
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Add padding
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (!Hive.isAdapterRegistered(1)) {
                  Hive.registerAdapter(ArtAdapter());
                }

                await Hive.initFlutter();

                final artBox = await Hive.openBox<Art>('movie');

                for (final art in arts) {
                  print(art.artName);
                }

                for (final key in artBox.keys) {}
              },
              child: const Text('Add Some Art'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white70,
                backgroundColor: Colors.black45,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final userBox = await Hive.openBox<User>('users');
                await userBox.clear();
                print('All user records have been cleared');
              },
              child: const Text('Clear Local Users'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white70,
                backgroundColor: Colors.black45,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: const NavBar(),
    );
  }
}
