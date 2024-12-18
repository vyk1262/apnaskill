import 'package:flutter/material.dart';

class CenteredTextWidget extends StatelessWidget {
  CenteredTextWidget({Key? key}) : super(key: key);

  final List<String> internshipTexts = [
    "ApnaSkill.in is your gateway to mastering technology. We're passionate about empowering students like YOU with the skills and practical experience needed to excel in your studies.",
    "Struggling to grasp concepts? Practice makes perfect! Quizzes, assignments, and projects are your keys to deeper understanding and confidence.",
    "The academic world can be challenging, but with structured practice through assignments and projects, you're building a solid foundation for success.",
    "Break away from traditional rote learning. Engage with flexible and interactive quizzes, assignments, and projects designed to fit your schedule.",
    "Ready to excel in your subjects? Practical learning through quizzes, assignments, and projects bridges the gap between theory and application, boosting your knowledge and skills."
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final text in internshipTexts) _buildTextCard(text),
        ],
      ),
    );
  }

  Widget _buildTextCard(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Card(
        elevation: 10, // Stronger shadow effect for depth
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20), // More rounded corners for elegance
        ),
        color: Colors.white,
        shadowColor: Colors.blueGrey, // Adjust shadow color for better contrast
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purpleAccent, Colors.blueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18, // Slightly larger font for better readability
                fontWeight:
                    FontWeight.w600, // Lighter weight for more sophistication
                color: Colors
                    .white, // Text color that contrasts nicely with the background
                letterSpacing:
                    1.2, // Adding space between letters for better readability
              ),
            ),
          ),
        ),
      ),
    );
  }
}
