import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final logger = Logger();

    Future<void> handleSignup() async {
      if (formKey.currentState!.validate()) {
        final name = nameController.text;
        final email = emailController.text;
       // final password = passwordController.text;

        logger.i('💡 Attempting signup with Name: $name, Email: $email');

        // Simulate async signup operation
        await Future.delayed(const Duration(seconds: 2));

        if (!context.mounted) return; // Ensure the context is still valid

        // Simulate success and navigate to LoginPage
        logger.i('✅ Signup successful!');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signup successful! Please log in.')),
        );
        Navigator.of(context).pop(); // Navigate back to LoginPage
      }
    }

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
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
            onPressed: handleSignup,
            child: const Text('Signup'),
          ),
        ],
      ),
    );
  }
}
