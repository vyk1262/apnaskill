import 'package:flutter/material.dart';

class WrapBenefitsSection extends StatelessWidget {
  // Data for the Wrap Benefits Section
  final Map<String, dynamic> pageData = const {
    'wrapBenefits': {
      'title': "Key Benefits of Our Quiz-Based Learning",
      'benefits': [
        {
          'emoji': "🧑‍💻",
          'title': "Personalized Quiz Experience",
          'description':
              "Quizzes tailored to your learning goals and progress, ensuring you focus on what matters most for your skill development.",
        },
        {
          'emoji': "💡",
          'title': "Learn from Expert Insights",
          'description':
              "Gain valuable insights and practical knowledge embedded within expertly crafted quiz questions and explanations.",
        },
        {
          'emoji': "📚",
          'title': "Concise Learning Through Quizzes",
          'description':
              "Efficiently grasp core concepts across various topics through well-structured and focused quiz formats.",
        },
        {
          'emoji': "❓",
          'title': "Weekly Quiz Doubt Clarification",
          'description':
              "Get your questions answered in our weekly sessions dedicated to resolving any doubts you encounter while practicing the quizzes.",
        },
        {
          'emoji': "⏱️",
          'title': "Quiz Anytime, Anywhere",
          'description':
              "Access our quizzes at your convenience and learn according to your own schedule.",
        },
        {
          'emoji': "📖",
          'title': "Explore Diverse Quiz Topics",
          'description':
              "Choose from a wide range of subjects and expand your knowledge through engaging quizzes.",
        },
        {
          'emoji': "📈",
          'title': "Immediate Quiz Results & Insights",
          'description':
              "Receive instant scores and detailed explanations after each quiz to track your progress and understand concepts quickly.",
        },
        {
          'emoji': "🧠",
          'title': "Smart Quiz Technology",
          'description':
              "Experience intelligent quizzes that adapt to your learning pace and identify areas for improvement, ensuring efficient and personalized skill development.",
        },
        {
          'emoji': "📚",
          'title': "Quizzes, Assignments, and Capstone Projects",
          'description':
              "Reinforce learning with regular assignments and quizzes. Showcase your skills through projects and a final capstone project for your portfolio.",
        },
        {
          'emoji': "⚡",
          'title': "Learning Through Problem-Solving",
          'description':
              "Move beyond theory by tackling real-world challenges that build practical skills employers are seeking.",
        },
        {
          'emoji': "👨‍🏫",
          'title': "Dedicated Mentor Support",
          'description':
              "Our mentors are here to guide you, answer questions, and support your learning journey every step of the way.",
        },
        {
          'emoji': "🎯",
          'title': "Practice Makes Perfect: Your Path to Mastery",
          'description':
              "Transform from beginner to expert with consistent, targeted practice quizzes designed for mastery.",
        },
        {
          'emoji': "⚙️",
          'title': "Interactive Learning & Instant Feedback",
          'description':
              "Engage with dynamic quizzes and get instant feedback to accelerate your learning.",
        },
        {
          'emoji': "🚀",
          'title': "Unlock Your Potential with Skill Factorial",
          'description':
              "Empowering learners with innovative quiz-based methods to bridge the gap between theory and practice.",
        },
      ],
    },
  };

  const WrapBenefitsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final benefits = pageData['wrapBenefits']['benefits'] as List;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 64.0),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Center(
        child: Column(
          children: [
            Text(
              pageData['wrapBenefits']['title']!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1f2937),
              ),
            ),
            const SizedBox(height: 48.0),
            Wrap(
              spacing: 16.0, // horizontal spacing
              runSpacing: 16.0, // vertical spacing
              alignment: WrapAlignment.center,
              children: benefits.map((benefit) {
                return _buildBenefitCard(benefit);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitCard(Map<String, String> benefit) {
    return Card(
      elevation: 8.0,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        width: 350,
        constraints: const BoxConstraints(minHeight: 220),
        padding: const EdgeInsets.all(32.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              benefit['emoji']!,
              style: const TextStyle(fontSize: 48.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              benefit['title']!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1f2937),
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              benefit['description']!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16.0,
                color: Color(0xFF4b5563),
              ),
            ),
          ],
        ),
      ),
    );
  }
}