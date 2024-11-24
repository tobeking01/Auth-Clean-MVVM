import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../bloc/appbar_bloc.dart';
import '../widgets/appbar_widget.dart';
import '../bloc/bottom_bloc.dart';
import '../widgets/bottom_widget.dart';
import '../../../authentication/domain/entities/user.dart';
import '../../../authentication/domain/usecases/logout_user.dart';

class HomePage extends StatelessWidget {
  final User user;
  final VoidCallback toggleTheme;

  const HomePage({super.key, required this.user, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBarBloc>(
          create: (_) => AppBarBloc(logoutUseCase: GetIt.I<LogoutUser>()),
        ),
        BlocProvider<BottomBloc>(
          create: (_) => BottomBloc(),
        ),
      ],
      child: Scaffold(
        appBar: AppBarWidget(
          title: 'Home',
          toggleTheme: toggleTheme,
          automaticallyImplyLeading: false, // Disables back button
        ),
        body: const BottomMenu(), // BottomMenu now handles theme colors
      ),
    );
  }
}
