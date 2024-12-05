import 'package:flutter_test_project/instances/user.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserSignedUp extends UserState {}

class UserSignUpFail extends UserState {
  final String errorMessage;

  UserSignUpFail(this.errorMessage);
}

class UserFindSuccess extends UserState {
  final User user;

  UserFindSuccess(this.user);
}

class UserFindFail extends UserState {}

class UserLoginSuccess extends UserState {}

class UserLoginFail extends UserState {}

class LogoutSuccess extends UserState {}

class UserUpdated extends UserState { final User user; UserUpdated(this.user); }
