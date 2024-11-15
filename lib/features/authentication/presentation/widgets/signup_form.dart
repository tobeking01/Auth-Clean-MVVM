import 'package:flutter/material.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          // TODO: Add name, email, and password fields
          ElevatedButton(
            onPressed: () {},
            child: Text('Signup'),
          ),
        ],
      ),
    );
  }
}
