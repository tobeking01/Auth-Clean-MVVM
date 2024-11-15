// lib/features/authentication/data/datasources/authentication_remote_data_source_impl.dart

import 'dart:convert';
import 'package:http/http.dart' as http; // Import http with alias
import 'package:auth_clean_mvvm/core/error/exceptions.dart';
import 'authentication_remote_data_source.dart';
import '../models/user_model.dart';

/// Implementation of [AuthenticationRemoteDataSource] using HTTP requests.
class AuthenticationRemoteDataSourceImpl implements AuthenticationRemoteDataSource {
  final http.Client client;

  AuthenticationRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await client.post(
      Uri.parse('https://yourapi.com/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> signup(String email, String password, String name) async {
    final response = await client.post(
      Uri.parse('https://yourapi.com/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password, 'name': name}),
    );

    if (response.statusCode == 201) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
