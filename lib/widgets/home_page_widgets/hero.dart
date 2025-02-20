import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_factorial/constants/colors.dart';
import 'package:skill_factorial/screens/register.dart';

import 'cta_button.dart';

class HeroWidget extends StatelessWidget {
  const HeroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primaryColor.withOpacity(0.2),
            AppColors.secondaryColor.withOpacity(0.2),
          ],
        ),
      ),
      child: Center(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: MediaQuery.of(context).size.width > 700
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        // Use Expanded instead of Flexible for equal distribution
                        flex: 1,
                        child: leftBar(context),
                      ),
                      Expanded(
                        // Use Expanded instead of Flexible for equal distribution
                        flex: 1,
                        child: rightBar(context),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      leftBar(context),
                      rightBar(context),
                    ],
                  )),
      ),
    );
  }

  Widget leftBar(BuildContext context) {
    // Return a Widget instead of a Column
    return Padding(
      // Add padding for better spacing
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Expand Your Knowledge Through Practice with Quizzes',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width > 700
                  ? 44
                  : 32, // Responsive font size
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            'Learn, Test, and Grow with Our Quizzes\nMaster New Skills with Practical Learning',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20), // Added spacing
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              textStyle: const TextStyle(fontSize: 16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.call),
                const SizedBox(width: 8),
                Text(
                  "Call Us : 8175989767",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: MediaQuery.of(context).size.width > 700
                        ? 20
                        : 16, // Responsive font size
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget rightBar(BuildContext context) {
    // Return a Widget instead of a Column
    return Padding(
      // Add padding for better spacing
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(FontAwesomeIcons.cloud),
          Text(
            'Join now to Learn More',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width > 700
                  ? 28
                  : 24, // Responsive font size
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          buildCtaButton(
            text: 'Start Learning',
            onPressed: () => context.go('/login'),
          ),
        ],
      ),
    );
  }
}
