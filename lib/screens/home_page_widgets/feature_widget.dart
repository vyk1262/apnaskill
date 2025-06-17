import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/colors.dart';

final List<Map<String, dynamic>> featureData = [
  {
    "icon": Icons.person,
    "title": "Personalized Quiz Experience",
    "description":
        "Quizzes tailored to your learning goals and progress, ensuring you focus on what matters most for your skill development."
  },
  {
    "icon": Icons.lightbulb_outline,
    "title": "Learn from Expert Insights (via Quiz Design)",
    "description":
        "Gain valuable insights and practical knowledge embedded within expertly crafted quiz questions and explanations."
  },
  {
    "icon": Icons.menu_book,
    "title": "Concise Learning Through Quizzes",
    "description":
        "Efficiently grasp core concepts across various topics through well-structured and focused quiz formats."
  },
  {
    "icon": FontAwesomeIcons.question,
    "title": "Weekly Quiz Doubt Clarification",
    "description":
        "Get your questions answered in our weekly sessions dedicated to resolving any doubts you encounter while practicing the quizzes."
  },
  {
    "icon": Icons.person,
    "title": "Quiz Anytime, Anywhere",
    "description":
        "Access our quizzes at your convenience and learn according to your own schedule."
  },
  {
    "icon": FontAwesomeIcons.book,
    "title": "Explore Diverse Quiz Topics",
    "description":
        "Choose from a wide range of subjects and expand your knowledge through engaging quizzes."
  },
  {
    "icon": FontAwesomeIcons.chartLine,
    "title": "Immediate Quiz Results & Insights",
    "description":
        "Receive instant scores and detailed explanations after each quiz to track your progress and understand concepts quickly."
  }
];

class FeatureGrid extends StatelessWidget {
  const FeatureGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 50,
      runSpacing: 20,
      alignment: WrapAlignment.center,
      children: featureData.map((data) {
        return SizedBox(
          width: 250,
          child: FeatureItem(
            icon: data['icon'] as IconData,
            title: data['title'],
            description: data['description'],
          ),
        );
      }).toList(),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const FeatureItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        gradient: AppColors.gradientPrimary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 32,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 12),
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.9),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
