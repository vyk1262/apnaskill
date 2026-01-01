import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skill_factorial/constants/custom_theme.dart';
import 'package:skill_factorial/screens/courses_home.dart';
import 'package:skill_factorial/screens/register.dart';
import 'package:url_strategy/url_strategy.dart';

import 'screens/profile_page_widgets/Profile.dart';
import 'firebase_options.dart';
import 'model/user_model.dart';
import 'screens/url_not_found.dart';

// removed go_router usage - using direct navigation

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

// GoRouter removed. Navigation will use Navigator and MaterialPageRoute.

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // bool isMobile = MediaQuery.of(context).size.width < 700;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skill Factorial',
      theme: CustomTheme.lightTheme,
      home: const QuizListHome(),
    );
  }
}
