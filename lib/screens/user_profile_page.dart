import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_project/bloc/test/test_bloc.dart';
import 'package:flutter_test_project/bloc/user_block/user_block.dart';
import 'package:flutter_test_project/bloc/user_block/user_event.dart';
import 'package:flutter_test_project/bloc/user_block/user_state.dart';
import 'package:flutter_test_project/elements/appbar.dart';
import 'package:flutter_test_project/elements/navbar.dart';
import 'package:flutter_test_project/instances/user.dart';
import 'package:flutter_test_project/screens/edit_profile_page.dart';

import '../bloc/test/test_event.dart';

class UserProfilePage extends StatefulWidget {
  final User user;

  const UserProfilePage(this.user, {super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  void initState() {
    super.initState();
    checkNetworkAutoLogin();
  }

  Future<void> checkNetworkAutoLogin() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title:
              const Text('No network connection but autologin is successful'),
          content: const Text(
            'Please check your internet connection and try again.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      //return;
    }
  }

  void navigateToEditPage(User user) {
    Navigator.push(
      context,
      MaterialPageRoute<User>(
        builder: (context) => EditProfilePage(user),
      ),
    );
  }

  Future<void> finallyLogout() async {
    final bool logout = await check();
    if (logout == true) {
      context.read<UserBloc>().add(Logout());
    }
  }

  Future<bool> check() async {
    bool result = false;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout?'),
          content: const Text('Do you really want to log out from the app'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() => result = true);
                Navigator.pop(context);
              },
              child: const Text('Yeah'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: MyAppBar(
        isAbleGoBack: false,
        appTitle: 'Profile',
        actions: [
          IconButton(
            onPressed: finallyLogout,
            tooltip: 'Show Snackbar',
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          height: size.height,
          child: Center(
            child: Column(
              //crossAxisAlignment: ,
              children: [
                Image.asset(
                  'assets/images/unknown.png',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 10),
                Text(
                  widget.user.username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.user.email,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => navigateToEditPage(widget.user),
                  child: const Text(
                    'Edit',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.read<TestBloc>().add(DeleteMovies());
                  },
                  child: const Text('Delete'),
                ),
                TextButton(
                  onPressed: () {
                    context.read<TestBloc>().add(UpdateMovies());
                  },
                  child: const Text('Update'),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
