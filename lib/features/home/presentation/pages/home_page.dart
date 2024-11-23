import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../authentication/domain/entities/user.dart';
import '../../../navigation/presentation/bloc/bottom_bloc.dart';
import '../../../navigation/presentation/pages/bottom_menu.dart';


class HomePage extends StatelessWidget {
  final User user;
  final VoidCallback toggleTheme;

  const HomePage({super.key, required this.user, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomBloc(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Home'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.brightness_6),
              onPressed: toggleTheme,
            ),
          ],
        ),
        body: const BottomMenu(), // Use BottomMenu widget
      ),
    );
  }
}
