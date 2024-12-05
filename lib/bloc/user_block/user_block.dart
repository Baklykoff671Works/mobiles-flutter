import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_project/bloc/user_block/user_event.dart';
import 'package:flutter_test_project/bloc/user_block/user_state.dart';
import 'package:flutter_test_project/instances/user.dart';

import 'package:flutter_test_project/service/authorization/authorization_service.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this.authorizationService) : super(UserInitial()) {
    on<UserSignUp>((event, emit) async {
      final result = await authorizationService.register(
        event.username,
        event.email,
        event.password,
      );
      if (result == null) {
        emit(UserSignedUp());
      } else {
        emit(UserSignUpFail(result));
      }
    });

    on<FindUser>((event, emit) async {
      final User? user = await authorizationService.findCurrentUser();
      if (user != null) {
        emit(UserFindSuccess(user));
      } else {
        emit(UserFindFail());
      }
    });

    on<LogInUser>((event, emit) async {
      final bool result = await authorizationService.login(
        event.email,
        event.password,
      );
      if (result) {
        emit(UserLoginSuccess());
      } else {
        emit(UserLoginFail());
      }
    });

    on<Logout>((event, emit) async {
      await authorizationService.logout();
      emit(LogoutSuccess());
    });

    on<UpdateUser>((event, emit) async {
      await authorizationService.updateUser(event.user);
      emit(UserUpdated(event.user));
    });

  }

  final AuthorizationService authorizationService;
}
