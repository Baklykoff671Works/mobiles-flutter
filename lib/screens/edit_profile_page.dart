import 'package:flutter/material.dart';
import 'package:flutter_test_project/elements/appbar.dart';
import 'package:flutter_test_project/elements/custom_button.dart';
import 'package:flutter_test_project/elements/custom_form.dart';
import 'package:flutter_test_project/elements/custom_title.dart';
import 'package:flutter_test_project/instances/user.dart';
import 'package:flutter_test_project/service/authorization/user_storage_service.dart';
import 'package:hive/hive.dart';

class EditProfilePage extends StatefulWidget {
  final User user;

  const EditProfilePage(this.user, {super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController emailController;
  final IUserStorageService userStorageService = UserStorageService();

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController(text: widget.user.username);
    passwordController = TextEditingController(text: widget.user.password);
    emailController = TextEditingController(text: widget.user.email);
  }

  Future<void> editUser() async {
    final editedPassword = passwordController.text;
    final editedUsername = usernameController.text;
    final editedUser = User(
      username: editedUsername,
      email: emailController.text,
      password: editedPassword,
    );
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserAdapter());
    }
    await userStorageService.saveUser(editedUser);
    Navigator.pushReplacementNamed(context, '/profile');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: const MyAppBar(
        isAbleGoBack: true,
        appTitle: 'Edit profile',
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const MyTitleAndSubtitle(
              mainTitle: 'Edit',
              subTitle: 'Edit your profile information',
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  MyCustomForm(
                    labelText: 'Username',
                    controller: usernameController,
                    isSecured: false,
                    icon: const Icon(Icons.verified_user),
                    hintText: 'Edit your username',
                  ),
                  const SizedBox(height: 30),
                  MyCustomForm(
                    labelText: 'Password',
                    controller: passwordController,
                    isSecured: false,
                    icon: const Icon(Icons.person),
                    hintText: 'Edit your password',
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: MyCustomButton(
                buttonText: 'Edit',
                textColor: Colors.white,
                buttonColor: Theme.of(context).colorScheme.primary,
                functionPressed: editUser,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
