import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/appbar_bloc.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback toggleTheme;
  final bool automaticallyImplyLeading;

  const AppBarWidget({
    super.key,
    required this.title,
    required this.toggleTheme,
    this.automaticallyImplyLeading = true, // Default value
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBarBloc, AppBarState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Navigator.of(context).pushReplacementNamed('/login');
        } else if (state is LogoutFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: automaticallyImplyLeading, // Pass parameter
        title: Text(
          title,
          style: const TextStyle(fontSize: 24),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: toggleTheme,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AppBarBloc>().add(LogoutEvent());
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
