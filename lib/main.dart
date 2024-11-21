import 'package:auth_clean_mvvm/core/injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'features/authentication/presentation/pages/home_page.dart';
import 'features/authentication/presentation/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies(); // Initialize dependency injection
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth-Clean-MVVM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login', // Set the initial route
      routes: {
        '/login': (context) => const LoginPage(), // Map to LoginPage
        '/home': (context) => const HomePage(),   // Map to HomePage
      },
    );
  }
}
