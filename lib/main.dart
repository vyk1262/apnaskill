import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skill_factorial/screens/explore.dart';
import 'package:skill_factorial/screens/syllabus_view.dart';
import 'package:skill_factorial/screens/courses_home.dart';
import 'package:skill_factorial/screens/faqs.dart';
import 'package:skill_factorial/screens/mentors.dart';
import 'package:skill_factorial/screens/register.dart';
import 'package:url_strategy/url_strategy.dart';

import 'Profile.dart';
import 'constants/colors.dart';
import 'firebase_options.dart';
import 'home.dart';
import 'model/user_model.dart';
import 'screens/url_not_found.dart';

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
          path: 'quizzes',
          builder: (context, state) => const QuizListHome(),
        ),
        GoRoute(
          path: 'login',
          builder: (context, state) => const AuthScreen(),
        ),
        GoRoute(
          path: 'mentors',
          builder: (context, state) => const Mentors(),
        ),
        GoRoute(
          path: 'explore',
          builder: (context, state) => Explore(),
        ),
        GoRoute(
          path: 'faqs',
          builder: (context, state) => FaqsScreen(),
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
          color: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
        iconTheme: const IconThemeData(
          color: AppColors.tertiaryColor,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.white,
          ),
          displayMedium: TextStyle(
            color: Colors.white,
          ),
          displaySmall: TextStyle(
            color: Colors.white,
          ),
          headlineLarge: TextStyle(
            color: Colors.white,
          ),
          headlineMedium: TextStyle(
            color: Colors.white,
          ),
          headlineSmall: TextStyle(
            color: Colors.white,
          ),
          titleLarge: TextStyle(
            color: Colors.white,
          ),
          titleMedium: TextStyle(
            color: Colors.white,
          ),
          titleSmall: TextStyle(
            color: Colors.white,
          ),
          bodyLarge: TextStyle(
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
          ),
          bodySmall: TextStyle(
            color: Colors.white,
          ),
          labelLarge: TextStyle(
            color: Colors.white,
          ),
          labelMedium: TextStyle(
            color: Colors.white,
          ),
          labelSmall: TextStyle(
            color: Colors.white,
          ),
        ),
        listTileTheme: const ListTileThemeData(
          iconColor: Colors.white,
          textColor: Colors.white,
          selectedColor: Colors.white,
          tileColor: Colors.purple,
          selectedTileColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white),
          hintStyle: TextStyle(color: Colors.grey),
          iconColor: Colors.white,
          prefixIconColor: Colors.white,
          suffixIconColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
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
        cardTheme: const CardTheme(
          color: Colors.black87,
        ),
        // radio list tile theme
        radioTheme: RadioThemeData(
          fillColor: MaterialStateColor.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.green; // Color when selected
            }
            return Colors.white; // Default color
          }),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
      // home: isMobile ? MobileTabs() : Tabs(),
    );
  }
}
