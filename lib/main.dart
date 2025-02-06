import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skill_factorial/screens/courses.dart';
import 'package:skill_factorial/screens/register.dart';
import 'package:url_strategy/url_strategy.dart';

import 'constants/colors.dart';
import 'firebase_options.dart';
import 'home.dart';
import 'model/user_model.dart';
import 'screens/url_not_found.dart';
import 'custom_app_bar.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// void main() => runApp(MyApp());
Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserModel(),
      child: MyApp(),
    ),
  );
}

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'courses',
          builder: (context, state) => const Courses(),
        ),
        GoRoute(
          path: 'login',
          builder: (context, state) => const AuthScreen(),
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => const NotFoundPage(),
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // bool isMobile = MediaQuery.of(context).size.width < 700;
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: 'Skill Factorial',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: AppColors.primaryColor,
          titleTextStyle: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: AppColors.tertiaryColor,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
          ),
          bodySmall: TextStyle(
            color: Colors.white24,
          ),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: AppColors.primaryColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryColor,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.primaryColor,
        ),
        // cardColor: Colors.black87,
      ),
      // home: isMobile ? MobileTabs() : Tabs(),
    );
  }
}
