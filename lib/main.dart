import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_project/bloc/art_bloc/art_data_bloc.dart';
import 'package:flutter_test_project/bloc/user_block/user_block.dart';
import 'package:flutter_test_project/screens/auth_profile_page.dart';
import 'package:flutter_test_project/screens/favourite_page.dart';
import 'package:flutter_test_project/screens/home_page.dart';
import 'package:flutter_test_project/screens/login_page.dart';
import 'package:flutter_test_project/screens/search_page.dart';
import 'package:flutter_test_project/screens/signup_page.dart';
import 'package:flutter_test_project/service/authorization/authorization_service.dart';
import 'package:flutter_test_project/service/movie/art_service.dart';

import 'bloc/test/test_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ArtService movieService = ArtService();
    final AuthorizationService authorizationService = AuthorizationService();
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(authorizationService),
        ),
        BlocProvider<ArtDataBloc>(
          create: (context) => ArtDataBloc(movieService),
        ),
        BlocProvider<TestBloc>(
          create: (context) => TestBloc(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo App',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(191, 191, 191, 1.0),
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromRGBO(124, 63, 0, 1.0),
            secondary: const Color.fromRGBO(191, 191, 191, 1.0),
            primary: const Color.fromRGBO(0, 0, 0, 1.0),
          ),
        ),
        routes: {
          '/': (context) => const MyHomePage(),
          '/search': (context) => const MySearchPage(),
          '/favourite': (context) => const MyFavouritePage(),
          '/profile': (context) => const AuthProfilePage(),
          '/login': (context) => const MyLoginPage(),
          '/signup': (context) => const MySignUpPage(),
        },
        initialRoute: '/',
      ),
    );
  }
}