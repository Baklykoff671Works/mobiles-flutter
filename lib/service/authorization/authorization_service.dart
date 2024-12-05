import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test_project/instances/user.dart';
import 'package:flutter_test_project/service/api/api_service.dart';
import 'package:flutter_test_project/service/authorization/user_storage_service.dart';
import 'package:hive_flutter/adapters.dart';

abstract class IAuthorizationService {
  Future<String?> register(String username, String email, String password);

  Future<bool> login(String email, String password);

  Future<User?> findCurrentUser();

  Future<void> logout();

  Future<String?> findCurrentUserEmail();
}

class AuthorizationService implements IAuthorizationService {
  final IUserStorageService userStorageService = UserStorageService();
  final IApiService apiService = ApiService();

  @override
  Future<String?> register(
    String username,
    String email,
    String password,
  ) async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserAdapter());
    }
    if (username.length < 6 || !email.contains('@gmail.com')) {
      return 'Validation Error';
    }
    final existUser = await userStorageService.getUser(email);
    if (existUser != null) {
      return 'User is already exist';
    }
    final User newUser = User(
      email: email,
      username: username,
      password: password,
    );
    await apiService.registerUser(newUser);
    await userStorageService.saveUser(newUser);
    return null;
  }

  @override
  Future<bool> login(String email, String password) async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserAdapter());
    }

    final authUser = await userStorageService.getUser(email);
    if (authUser != null) {
      if (password == authUser.password) {
        await Hive.initFlutter();
        final stringBox = await Hive.openBox<String>('currentUser');
        await stringBox.put('currentEmail', email);
        return true;
      }
    }
    return false;
  }

  @override
  Future<User?> findCurrentUser() async {
    await Hive.initFlutter();
    final stringBox = await Hive.openBox<String>('currentUser');
    final currentUserEmail = stringBox.get('currentEmail');
    if (currentUserEmail == null) {
      return null;
    }
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserAdapter());
    }

    await Hive.initFlutter();

    final userBox = await Hive.openBox<User>('users');

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return userBox.get(currentUserEmail);
    } else {
      return apiService.getUserByEmail(currentUserEmail);
    }
  }

  @override
  Future<void> logout() async {
    await Hive.initFlutter();
    final stringBox = await Hive.openBox<String>('currentUser');
    await stringBox.delete('currentEmail');
  }

  @override
  Future<void> updateUser(User user) async {
    final userBox = await Hive.openBox<User>('users');
    await userBox.put(user.email, user);
  }

  @override
  Future<String?> findCurrentUserEmail() async {
    await Hive.initFlutter();
    final stringBox = await Hive.openBox<String>('currentUser');
    final currentUserEmail = stringBox.get('currentEmail');
    if (currentUserEmail == null) {
      return null;
    } else {
      return currentUserEmail;
    }
  }
}
