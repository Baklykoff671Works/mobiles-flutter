import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_project/bloc/art_bloc/art_data_bloc.dart';
import 'package:flutter_test_project/bloc/art_bloc/art_data_event.dart';
import 'package:flutter_test_project/bloc/art_bloc/art_data_state.dart';
import 'package:flutter_test_project/bloc/test/test_bloc.dart';
import 'package:flutter_test_project/bloc/test/test_state.dart';
import 'package:flutter_test_project/bloc/user_block/user_block.dart';
import 'package:flutter_test_project/bloc/user_block/user_event.dart';
import 'package:flutter_test_project/bloc/user_block/user_state.dart';
import 'package:flutter_test_project/elements/appbar.dart';
import 'package:flutter_test_project/elements/art_card.dart';
import 'package:flutter_test_project/elements/navbar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late StreamSubscription subscription;
  late ArtDataBloc artBloc;
  late UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    artBloc = BlocProvider.of<ArtDataBloc>(context);
    artBloc.add(LoadArtData());
    userBloc = BlocProvider.of<UserBloc>(context);
    userBloc.add(FindUser());
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const MyAppBar(
        isAbleGoBack: false,
        appTitle: 'Welcome to GreatestArtExhibition',
      ),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserFindSuccess) {
            subscription = Connectivity()
                .onConnectivityChanged
                .listen((ConnectivityResult result) {
              final hasInternet = result != ConnectivityResult.none;
              if (!hasInternet) {
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
              }
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
          child: Container(
            height: size.height,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Row(
                    children: [
                      Text(
                        'Now showing',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Spacer(),
                      Text('See more'),
                    ],
                  ),
                ),
                Flexible(
                  child: BlocBuilder<TestBloc, TestState>(
                    builder: (context, state) {
                      if (state is TestDeleted) {
                        return Container();
                      } else if (state is TestUpdated) {
                        return BlocBuilder<ArtDataBloc, ArtDataState>(
                          bloc: artBloc,
                          builder: (context, state) {
                            if (state is ArtDataLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (state is ArtDataLoaded) {
                              return ListView.separated(
                                scrollDirection: Axis.vertical,
                                itemCount: state.arts.length,
                                shrinkWrap: true,
                                primary: false,
                                separatorBuilder: (context, _) => const SizedBox(height: 8),
                                itemBuilder: (context, index) => ArtCard(
                                  art: state.arts[index],
                                ),
                              );
                            }
                            return Container();
                          },
                        );
                      }
                      return Container();
                    },
                  ),
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
