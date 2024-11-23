import 'package:auth_clean_mvvm/core/injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'features/authentication/domain/entities/user.dart';
import 'features/authentication/presentation/pages/login_page.dart';
import 'features/authentication/presentation/pages/signup_page.dart';
import 'features/home/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies(); // Initialize dependency injection
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkTheme = false; // Toggle for theme mode

  void toggleTheme() {
    setState(() {
      isDarkTheme = !isDarkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth-Clean-MVVM',
      debugShowCheckedModeBanner: false,
      theme: isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      initialRoute: '/login',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(
                builder: (context) => LoginPage(toggleTheme: toggleTheme));
          case '/signup':
            return MaterialPageRoute(
                builder: (context) => SignupPage(toggleTheme: toggleTheme));
          case '/home':
            final user = settings.arguments as User;
            return MaterialPageRoute(
              builder: (context) =>
                  HomePage(user: user, toggleTheme: toggleTheme),
            );
          default:
            return MaterialPageRoute(
                builder: (context) => LoginPage(toggleTheme: toggleTheme));
        }
      },
    );
  }
}
