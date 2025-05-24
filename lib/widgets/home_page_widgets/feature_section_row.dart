import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_factorial/widgets/cached_network_image_widget.dart';
import 'package:skill_factorial/widgets/home_page_widgets/cta_button.dart';

class FeatureSectionRow extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final int index; // Add index to the constructor

  static List<Map<String, String>> get techContent => [
        {
          "image": "https://i.ibb.co/q3cwJtB0/group-wh-d.png",
          "title": "Master Skills Through Engaging Quizzes",
          "description":
              "Unlock your potential with interactive quizzes designed for rapid learning and comprehensive understanding. Practice, reinforce your knowledge, and become a proficient professional faster."
        },
        {
          "image": "https://i.ibb.co/kgrp7qL3/group-wh-a.png",
          "title": "Learn Faster, Understand Deeper with Quiz-Based Learning",
          "description":
              "Skill Factorial bridges the gap between theory and application and empowers you to grasp complex topics quickly through focused quizzes. Maximize your learning efficiency and gain a holistic understanding of subjects in less time. Start practicing and accelerate your skill development journey today!"
        },
        {
          "image": "https://i.ibb.co/0pcVMkt3/group-wh-c.png",
          "title": "Unlock Your Potential with Skill Factorial",
          "description":
              "Skill Factorial.com is your gateway to mastering technology. We're passionate about empowering students like YOU with the skills and practical experience needed to excel in your studies."
        },
        {
          "image": "https://i.ibb.co/gLm03C2w/group-wh-b.png",
          "title": "Unlock Your Potential with Skill Factorial",
          "description":
              "The academic world can be challenging, but with structured practice through assignments and projects, you're building a solid foundation for success."
        }
      ];

  static Widget buildFeatureList() {
    return Column(
      children: techContent
          .asMap() // Use asMap to get index along with content
          .entries // Get iterable of MapEntry (index, content)
          .map(
            (entry) => FeatureSectionRow(
              imageUrl: entry.value["image"]!,
              title: entry.value["title"]!,
              description: entry.value["description"]!,
              index: entry.key, // Pass the index here
            ),
          )
          .toList(),
    );
  }

  const FeatureSectionRow({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.index, // Require index in the constructor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 700) {
            // Mobile layout (image on top, then text)
            return Column(
              children: [
                _buildMobileImage(),
                const SizedBox(height: 10),
                _buildContent(context),
              ],
            );
          }
          // Desktop layout
          return Row(
            children: [
              // Alternating logic based on index
              if (index % 2 == 0) ...[
                // Even index: Text on left, Image on right
                Expanded(child: _buildContent(context)),
                _buildDesktopImage()
              ] else ...[
                // Odd index: Image on left, Text on right
                _buildDesktopImage(),
                Expanded(child: _buildContent(context))
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildDesktopImage() {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CachedNetworkImageWidget(
            imageUrl: imageUrl,
            height: 400,
            fit: BoxFit.cover,
            errorWidget: const Icon(Icons.broken_image),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileImage() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImageWidget(
          imageUrl: imageUrl,
          height: 400,
          fit: BoxFit.cover,
          errorWidget: const Icon(Icons.broken_image),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            description,
            style: TextStyle(
              fontSize: 18,
              // color: Colors.grey.shade700,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          buildCtaButton(
            text: "Learn More",
            onPressed: () => context.go('/login'),
          ),
        ],
      ),
    );
  }
}
