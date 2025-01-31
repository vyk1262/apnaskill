import 'package:flutter/material.dart';
import 'package:skill_factorial/screens/register.dart';
import 'package:skill_factorial/widgets/helper_nav_func.dart';

import 'cta_button.dart';

class HeroWidget extends StatelessWidget {
  const HeroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          'https://images.unsplash.com/photo-1523240795612-9a054b0db644',
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.7,
          fit: BoxFit.cover,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
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
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Learn, Test, and Grow with Our Educational Quizzes',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    'Master New Skills with Practical Learning',
                    style: TextStyle(
                      fontSize: 20,
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
        ),
      ],
    );
  }
}
