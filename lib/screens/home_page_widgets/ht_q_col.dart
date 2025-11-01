import 'package:flutter/material.dart';

class ColumnFeaturesSection extends StatelessWidget {
  // Data for the Column Features Section
  final Map<String, dynamic> pageData = const {
    'columnFeatures': {
      'title': "Accelerate Your Learning with Our Features",
      'features': [
        {
          'imageSrc': "https://i.ibb.co/q3cwJtB0/group-wh-d.png",
          'altText': "Master Skills Through Engaging Quizzes",
          'title': "Master Skills Through Engaging Quizzes",
          'description':
              "Unlock your potential with interactive quizzes designed for rapid learning and comprehensive understanding. Practice, reinforce your knowledge, and become a proficient professional faster.",
        },
        {
          'imageSrc': "https://i.ibb.co/kgrp7qL3/group-wh-a.png",
          'altText': "Learn Faster, Understand Deeper",
          'title': "Learn Faster, Understand Deeper with Quiz-Based Learning",
          'description':
              "Skill Factorial bridges the gap between theory and application and empowers you to grasp complex topics quickly through focused quizzes. Maximize your learning efficiency and gain a holistic understanding of subjects in less time. Start practicing and accelerate your skill development journey today!",
        },
        {
          'imageSrc': "https://i.ibb.co/0pcVMkt3/group-wh-c.png",
          'altText': "Unlock Your Potential with Skill Factorial",
          'title': "Unlock Your Potential with Skill Factorial",
          'description':
              "Skill Factorial.com is your gateway to mastering technology. We're passionate about empowering students like YOU with the skills and practical experience needed to excel in your studies.",
        },
        {
          'imageSrc': "https://i.ibb.co/gLm03C2w/group-wh-b.png",
          'altText': "Structured Practice",
          'title': "Structured Practice",
          'description':
              "The academic world can be challenging, but with structured practice through assignments and projects, you're building a solid foundation for success.",
        },
      ],
    },
  };

  const ColumnFeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final features = pageData['columnFeatures']['features'] as List;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 64.0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(
                0xFF1e3a8a), // Corresponds to the dark blue in the CSS gradient
            Color(0xFF0f172a), // Corresponds to the darker blue-gray in the CSS
          ],
        ),
      ),
      child: Column(
        children: [
          Text(
            pageData['columnFeatures']['title']!,
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
              childAspectRatio: 0.8,
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
    );
  }

  Widget _buildFeatureCard(Map<String, String> feature) {
    return Card(
      elevation: 8.0,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(32.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          children: [
            Image.network(
              feature['imageSrc']!,
              height: 150.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16.0),
            Text(
              feature['title']!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1f2937),
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: Text(
                feature['description']!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Color(0xFF4b5563),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
