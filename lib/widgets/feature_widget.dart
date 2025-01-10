import 'package:flutter/material.dart';

class LearningFeaturesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Optional Title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // First Feature
              FeatureItem(
                icon: Icons.person,
                title: "Personalized Learning Programs",
                description:
                    "Tailored educational experiences designed to meet individual student needs and learning styles.",
              ),
              // Second Feature
              FeatureItem(
                icon: Icons.lightbulb_outline,
                title: "Expert-Led Workshops",
                description:
                    "Interactive sessions with industry experts aimed at skill enhancement and real-world application.",
              ),
              // Third Feature
              FeatureItem(
                icon: Icons.menu_book,
                title: "Comprehensive Course Materials",
                description:
                    "Well-structured resources providing in-depth knowledge across various subjects and disciplines.",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Icon(
              icon,
              size: 48,
              color: Colors.black87,
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {
                // Add action here
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.blue),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: Text("More info"),
            ),
          ],
        ),
      ),
    );
  }
}
