import 'package:flutter/material.dart';
import '../widgets/signup_form.dart';

class SignupPage extends StatelessWidget {
  final VoidCallback toggleTheme;

  const SignupPage({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Create Account'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: toggleTheme, // Toggle theme mode
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: IntrinsicHeight(
                child: const SignupForm(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
