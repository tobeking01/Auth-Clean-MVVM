import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auth_clean_mvvm/core/error/exceptions.dart';
import 'package:logger/logger.dart';
import '../models/user_model.dart';
import 'authentication_remote_data_source.dart';

/// Implementation of [AuthenticationRemoteDataSource] using HTTP requests.
class AuthenticationRemoteDataSourceImpl implements AuthenticationRemoteDataSource {
  final http.Client client;
  final Logger logger = Logger();

  AuthenticationRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await client.post(
      Uri.parse('http://10.0.2.2:3000/api/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      // Validate response structure
      if (responseData.containsKey('token') &&
          responseData.containsKey('user')) {
        final user = UserModel.fromJson(responseData['user']);
        logger.i('Login successful. Token: ${responseData['token']}');
        return user;
      } else {
        logger.e('Invalid response structure: ${response.body}');
        throw ServerException('Invalid response structure');
      }
    } else {
      logger.e('Login failed with status code: ${response.statusCode}');
      throw ServerException('Login failed with status code ${response.statusCode}');
    }
  }

  @override
  Future<UserModel> signup(String username, String email, String password) async {
    final response = await client.post(
      Uri.parse('http://10.0.2.2:3000/api/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'email': email,
      }),
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);

      // Parse the response and validate structure
      if (responseData['token'] != null && responseData['user'] != null) {
        final user = UserModel.fromJson(responseData['user']);
        logger.i('Signup successful. Token: ${responseData['token']}');
        return user;
      } else {
        logger.e('Invalid response structure: ${response.body}');
        throw ServerException('Invalid response structure');
      }
    } else {
      logger.e(
          'Signup failed. Status Code: ${response.statusCode}, Body: ${response.body}');
      throw ServerException('Signup failed with status code ${response.statusCode}');
    }
  }
}
