import 'dart:convert';
import 'package:flutter_test_project/instances/user.dart';
import 'package:http/http.dart' as http;

abstract class IApiService {
  Future<void> registerUser(User user);

  Future<User?> getUserByEmail(String userEmail);
}

class ApiService implements IApiService {
  @override
  Future<void> registerUser(User user) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:5050/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );
  }

  @override
  Future<User?> getUserByEmail(String userEmail) async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:5050/users/$userEmail'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedResponse =
          jsonDecode(response.body) as Map<String, dynamic>;
      return User.fromJson(decodedResponse);
    } else {
      return null;
    }
  }
}
