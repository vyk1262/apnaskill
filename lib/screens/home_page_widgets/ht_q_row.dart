import 'package:flutter/material.dart';

class RowFeaturesSection extends StatelessWidget {
  // Data for the Row Features Section
  final Map<String, dynamic> pageData = const {
    'rowFeatures': {
      'title':
          "Innovative Learning: Learn From Anywhere: Test Your Knowledge & Get Certified",
      'features': [
        {
          'title': "Flexible Learning Access",
          'description':
              "Learn from anywhere at your own pace. All you need is an internet connection, and your learning journey continues without barriers.",
        },
        {
          'title': "Quizzes That Matter",
          'description':
              "Every quiz is designed to test your understanding and strengthen your grasp on concepts, preparing you for real-world applications.",
        },
        {
          'title': "Assignments & Projects",
          'description':
              "Apply what you’ve learned through assignments and hands-on projects. Build a portfolio that reflects your skills and stands out to employers.",
        },
        {
          'title': "Workshops & Bootcamps",
          'description':
              "Join live workshops and bootcamps where you’ll collaborate, solve problems, and gain practical knowledge directly from experts.",
        },
        {
          'title': "Certification for Your Growth",
          'description':
              "Get certified based on your performance in quizzes, assignments, and projects — a recognition of your hard work and progress.",
        },
      ],
    },
  };

  const RowFeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final features = pageData['rowFeatures']['features'] as List;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 64.0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0f172a), // Dark Blue-Gray
            Color(0xFF1e293b), // Lighter Dark Blue-Gray
          ],
        ),
      ),
      child: Center(
        child: Column(
          children: [
            Text(
              pageData['rowFeatures']['title']!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 48.0),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400.0,
                childAspectRatio: 1.2,
                crossAxisSpacing: 24.0,
                mainAxisSpacing: 24.0,
              ),
              itemCount: features.length,
              itemBuilder: (context, index) {
                final feature = features[index];
                return _buildFeatureCard(feature);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(Map<String, String> feature) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1f2937),
        border: Border.all(color: const Color(0xFF334155)),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            feature['title']!,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF38bdf8), // Cyan accent
            ),
          ),
          const SizedBox(height: 12.0),
          Text(
            feature['description']!,
            style: const TextStyle(
              fontSize: 16.0,
              color: Color(0xFFcbd5e1), // Gray 300
            ),
          ),
        ],
      ),
    );
  }
}
