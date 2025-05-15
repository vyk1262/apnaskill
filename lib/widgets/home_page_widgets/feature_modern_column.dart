import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_factorial/screens/register.dart';
import 'package:skill_factorial/widgets/cached_network_image_widget.dart';
import 'package:skill_factorial/widgets/home_page_widgets/cta_button.dart';

class FeatureModernColumn extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  static List<Map<String, String>> get techContent => [
        {
          "image": "https://i.ibb.co/QvQng1gc/q1.png",
          "title": "Smart Quiz Technology",
          "description":
              "Experience intelligent quizzes that adapt to your learning pace and identify areas for improvement, ensuring efficient and personalized skill development."
        },
        {
          "image": "https://i.ibb.co/ymn91tjg/q2.png",
          "title": "Practice Makes Perfect: Your Path to Mastery",
          "description":
              "Dive into a world of targeted practice quizzes designed to transform you from a beginner to an expert. Consistent practice on Skill Factorial is your key to career success."
        },
        {
          "image": "https://i.ibb.co/pjVQPd3S/q3.png",
          "title": "Interactive Learning & Instant Feedback",
          "description":
              "Engage with dynamic quizzes and receive immediate feedback to reinforce your understanding and accelerate your learning journey."
        },
        {
          "image": "https://i.ibb.co/KRVXDxc/q4.png",
          "title": "Unlock Your Potential with Skill Factorial's Quizzes",
          "description":
              "Based in Hyderabad, Skill Factorial is dedicated to empowering you with practical skills through innovative quiz-based learning. Bridge the gap between theory and application and achieve your career goals efficiently. Join us and grow!"
        }
      ];

  static Widget buildFeatureGrid() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: techContent
          .map(
            (content) => SizedBox(
              width: 450,
              child: FeatureModernColumn(
                imageUrl: content["image"]!,
                title: content["title"]!,
                description: content["description"]!,
              ),
            ),
          )
          .toList(),
    );
  }

  const FeatureModernColumn({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              child: CachedNetworkImageWidget(
                imageUrl: imageUrl,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorWidget: const Icon(Icons.broken_image),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 100,
                    child: SingleChildScrollView(
                      child: Text(
                        description,
                        style: TextStyle(
                          fontSize: 16,
                          // color: Colors.grey.shade700,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  buildCtaButton(
                    text: "Learn More",
                    onPressed: () => context.go('/login'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
