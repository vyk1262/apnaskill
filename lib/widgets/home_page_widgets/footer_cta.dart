import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_factorial/constants/colors.dart';
import 'cta_button.dart';

class FooterCTA extends StatelessWidget {
  const FooterCTA({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: AppColors.gradientPrimaryMain,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ready to Test Your Knowledge?',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            buildCtaButton(
              text: "Begin Your Quiz Journey",
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
