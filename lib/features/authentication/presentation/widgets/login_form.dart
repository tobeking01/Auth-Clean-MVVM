import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final logger = Logger();

    Future<void> handleLogin() async {
      if (formKey.currentState!.validate()) {
        final email = emailController.text;
        final password = passwordController.text;

        logger.i('💡 Attempting login with Email: $email, Password: $password');

        // Simulating async operation
        await Future.delayed(const Duration(seconds: 2)); 

        if (!context.mounted) return; // Ensure the context is still valid
        
        // Simulate success and navigate to HomeScreen
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful!')),
        );
        Navigator.of(context).pushReplacementNamed('/home');
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
