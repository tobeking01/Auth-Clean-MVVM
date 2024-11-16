import 'package:flutter/material.dart';

import '../widgets/signup_form.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Signup'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Centers content vertically
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              SignupForm(),
            ],
          ),
        ),
      ),
    );
  }
}