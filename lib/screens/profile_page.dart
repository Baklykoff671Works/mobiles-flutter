import 'package:flutter/material.dart';
import 'package:flutter_test_project/elements/appbar.dart';
import 'package:flutter_test_project/elements/custom_button.dart';
import 'package:flutter_test_project/elements/custom_title.dart';
import 'package:flutter_test_project/elements/navbar.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: const MyAppBar(
        isAbleGoBack: false,
        appTitle: 'Greatest Art Exhibition',
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const MyTitleAndSubtitle(
              mainTitle: 'Welcome',
              subTitle: 'Enjoy the precious pieces of best artworks of history. Escape the grey reality with our pocket museum',
            ),
            Container(
              height: size.height / 3,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/real.png'),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  MyCustomButton(
                    buttonText: 'Login',
                    textColor: Theme.of(context).colorScheme.primary,
                    buttonColor: Colors.white,
                    functionPressed: () => {
                      Navigator.pushNamed(context, '/login'),
                    },
                  ),
                  const SizedBox(height: 15),
                  MyCustomButton(
                    buttonText: 'Sign up',
                    textColor: Colors.white,
                    buttonColor: Theme.of(context).colorScheme.primary,
                    functionPressed: () => {
                      Navigator.pushNamed(context, '/signup'),
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
