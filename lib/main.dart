import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'constants/colors.dart';
import 'firebase_options.dart';
import 'model/user_model.dart';
import 'tabs.dart';

Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 700;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
            color: Colors.red,
          ),
          bodyMedium: TextStyle(
            color: Colors.black,
          ),
          bodySmall: TextStyle(
            color: Colors.green,
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
      ),
      home: isMobile ? MobileTabs() : Tabs(),
    );
  }
}
