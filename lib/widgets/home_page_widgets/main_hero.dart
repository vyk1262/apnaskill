import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'cta_button.dart';

class MainHero extends StatelessWidget {
  const MainHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue.shade800,
            Colors.blue.shade500,
            Colors.blue.shade200,
            Colors.white,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Elevate Your Skills',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Join our platform to learn and grow with quizzes, and connect with experts to solve your doubts',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            buildCtaButton(
              text: 'Get Started Now',
              onPressed: () => context.go('/login'),
              bgColor: Colors.white,
              fgColor: Colors.blue.shade800,
            ),
          ],
        ),
      ),
    );
  }
}
