import 'package:flutter_test_project/instances/user.dart';
import 'package:hive_flutter/adapters.dart';

abstract class IUserStorageService {
  Future<void> saveUser(User user);

  Future<User?> getUser(String email);
}

class UserStorageService implements IUserStorageService {
  @override
  Future<void> saveUser(User user) async {
    await Hive.initFlutter();

    final userBox = await Hive.openBox<User>('users');

    await userBox.put(user.email, user);
  }

  @override
  Future<User?> getUser(String email) async {
    await Hive.initFlutter();

    final userBox = await Hive.openBox<User>('users');

    final user = userBox.get(email);

    return user;
  }
}
