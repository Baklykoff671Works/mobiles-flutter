import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_project/bloc/user_block/user_block.dart';
import 'package:flutter_test_project/bloc/user_block/user_event.dart';
import 'package:flutter_test_project/bloc/user_block/user_state.dart';
import 'package:flutter_test_project/screens/profile_page.dart';
import 'package:flutter_test_project/screens/user_profile_page.dart';

class AuthProfilePage extends StatefulWidget {
  const AuthProfilePage({super.key});

  @override
  State<AuthProfilePage> createState() => _AuthProfilePageState();
}

class _AuthProfilePageState extends State<AuthProfilePage> {
  late UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    userBloc = BlocProvider.of<UserBloc>(context);
    userBloc.add(FindUser());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      bloc: userBloc,
      builder: (context, state) {
        if (state is UserFindSuccess) {
          return UserProfilePage(state.user);
        }
        return const MyProfilePage();
      },
    );
  }
}
