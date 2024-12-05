import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_project/bloc/user_block/user_block.dart';
import 'package:flutter_test_project/bloc/user_block/user_event.dart';
import 'package:flutter_test_project/bloc/user_block/user_state.dart';
import 'package:flutter_test_project/elements/appbar.dart';
import 'package:flutter_test_project/elements/custom_button.dart';
import 'package:flutter_test_project/elements/custom_form.dart';
import 'package:flutter_test_project/elements/custom_title.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  Future<void> finallyLogin() async {
    final email = emailController.text;
    final password = passwordController.text;
    final ConnectivityResult result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('No network connection'),
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
    } else {
      context.read<UserBloc>().add(LogInUser(email, password));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(
        isAbleGoBack: true,
        appTitle: 'Greatest Art Exhibition',
      ),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserLoginSuccess) {
            Navigator.pushReplacementNamed(context, '/');
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Authorization is successful'),
                content:
                    const Text('Welcome to our Mobile Art Gallery, you`re a welcomed guest'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Hi'),
                    child: const Text('Ok'),
                  ),
                ],
              ),
            );
          } else if (state is UserLoginFail) {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('non-existent user'),
                content:
                    const Text('Invalid email or password. Please try again.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Hi'),
                    child: const Text('Ok'),
                  ),
                ],
              ),
            );
          }
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const MyTitleAndSubtitle(
                mainTitle: 'Login',
                subTitle: 'Login to your account',
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    MyCustomForm(
                      controller: emailController,
                      isSecured: false,
                      icon: const Icon(Icons.email),
                      hintText: 'Type your email',
                    ),
                    const SizedBox(height: 30),
                    MyCustomForm(
                      controller: passwordController,
                      isSecured: true,
                      icon: const Icon(Icons.person),
                      hintText: 'Type your password',
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: MyCustomButton(
                  buttonText: 'Login',
                  textColor: Colors.white,
                  buttonColor: Theme.of(context).colorScheme.primary,
                  functionPressed: finallyLogin,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Don`t have an account?',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {
                      Navigator.pushNamed(context, '/signup'),
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: size.height / 4,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/loginn.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
