import 'package:flutter/material.dart';
import 'core/injectable/injectable.dart';
import 'features/authentication/presentation/pages/login_page.dart';
import 'features/authentication/presentation/pages/signup_page.dart';
import 'features/home/presentation/pages/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set up dependency injection
  await setupDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Auth Clean MVVM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
