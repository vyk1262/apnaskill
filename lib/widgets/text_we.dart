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
        children: [
          for (final text in internshipTexts) _buildTextCard(text),
        ],
      ),
    );
  }

  Widget _buildTextCard(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(2, 2),
            )
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
