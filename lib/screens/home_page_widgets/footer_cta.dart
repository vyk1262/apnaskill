import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_factorial/constants/colors.dart';
import 'cta_button.dart';

class FooterCTA extends StatelessWidget {
  final Map<String, dynamic> pageData = const {
    'cta': {
      'subtitle':
          "Spaces are limited. Secure your spot in the next cohort and start your journey towards a high-paying tech career.",
      'buttonText': "Apply Now",
    },
  };

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
              'Ready to Test Your Knowledge and Kickstart Your Career?',
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
            const SizedBox(height: 32),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 64.0),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFF14b8a6), // var(--color-secondary)
                    Color(0xFF4f46e5), // var(--color-primary)
                  ],
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      constraints: const BoxConstraints(maxWidth: 600.0),
                      child: Text(
                        pageData['cta']['subtitle']!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implement CTA action (e.g., show a modal)
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFFfacc15), // btn-cta-yellow
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        elevation: 10.0,
                        shadowColor: Colors.black.withOpacity(0.25),
                      ),
                      child: Text(
                        pageData['cta']['buttonText']!,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF111111),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
