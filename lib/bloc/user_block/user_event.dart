import 'package:flutter_test_project/instances/user.dart';
abstract class UserEvent {}

class UserSignUp extends UserEvent {
  final String username;
  final String email;
  final String password;

  UserSignUp(this.username, this.email, this.password);
}

class FindUser extends UserEvent {}

class LogInUser extends UserEvent {
  final String email;
  final String password;

  LogInUser(this.email, this.password);
}

class Logout extends UserEvent {}

class UpdateUser extends UserEvent { final User user; UpdateUser(this.user); }
