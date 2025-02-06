import 'package:flutter/material.dart';
import 'package:skill_factorial/constants/colors.dart';
import 'package:skill_factorial/screens/register.dart';
import 'package:skill_factorial/widgets/helper_nav_func.dart';

import 'cta_button.dart';

// Image.asset(
//           'assets/book_shelf.png',
//           width: double.infinity,
//           height: MediaQuery.of(context).size.height * 0.7,
//           fit: BoxFit.cover,
//         ),

class HeroWidget extends StatelessWidget {
  const HeroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primaryColor,
            AppColors.secondaryColor,
          ],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Expand Your Knowledge Through Interactive Quizzes',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                'Learn, Test, and Grow with Our Educational Quizzes',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const Text(
                'Master New Skills with Practical Learning',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              buildCtaButton(
                text: 'Start Learning',
                onPressed: () =>
                    navigateTo(context, AuthScreen(), replace: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
