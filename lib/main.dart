import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skill_factorial/custom_theme.dart';
import 'package:skill_factorial/screens/explore.dart';
import 'package:skill_factorial/screens/games/game_fast_math.dart';
import 'package:skill_factorial/screens/games/game_number_series.dart';
import 'package:skill_factorial/screens/syllabus_view.dart';
import 'package:skill_factorial/screens/courses_home.dart';
import 'package:skill_factorial/screens/faqs.dart';
import 'package:skill_factorial/screens/mentors.dart';
import 'package:skill_factorial/screens/register.dart';
import 'package:skill_factorial/screens/jobs.dart';
import 'package:skill_factorial/screens/colleges.dart';
import 'package:url_strategy/url_strategy.dart';

import 'Profile.dart';
import 'constants/colors.dart';
import 'firebase_options.dart';
import 'home.dart';
import 'model/user_model.dart';
import 'screens/blogs.dart';
import 'screens/games/game_chess.dart';
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
          path: 'blogs',
          builder: (context, state) => BlogHomeScreen(),
        ),
        GoRoute(
          path: 'faqs',
          builder: (context, state) => FaqsScreen(),
        ),
        GoRoute(
          path: 'jobs',
          builder: (context, state) => const JobsScreen(),
        ),
        GoRoute(
          path: 'colleges',
          builder: (context, state) => const UniversitiesScreen(),
        ),
        GoRoute(
          path: 'chess',
          builder: (context, state) => const GameChess(),
        ),
        GoRoute(
          path: 'series',
          builder: (context, state) => GameNumberSeries(),
        ),
        GoRoute(
          path: 'fastmath',
          builder: (context, state) => GameFastMath(),
        ),
      ],
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
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
      theme: CustomTheme.lightTheme,
      // home: isMobile ? MobileTabs() : Tabs(),
    );
  }
}
