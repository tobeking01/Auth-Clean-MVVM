import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import '../../data/datasources/authentication_remote_data_source_impl.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final logger = Logger();

    // Initialize the remote data source
    final remoteDataSource = AuthenticationRemoteDataSourceImpl(client: http.Client());

    Future<void> handleLogin() async {
      if (formKey.currentState!.validate()) {
        final email = emailController.text;
        final password = passwordController.text;

        logger.i('💡 Attempting login with Email: $email');

        try {
          final user = await remoteDataSource.login(email, password);
          logger.i('✅ Login successful for user: ${user.toJson()}');

          if (!context.mounted) return;

          // Navigate to the home page on successful login
          Navigator.of(context).pushReplacementNamed('/home');
        } catch (e) {
          logger.e('❌ Login failed: $e');

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login failed. Please try again.')),
            );
          }
        }
      }
    }

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: handleLogin,
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
