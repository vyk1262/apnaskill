// why_choose.dart

import 'package:flutter/material.dart';

class WhyChooseUs extends StatelessWidget {
  const WhyChooseUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(20.0),
      child: const Column(
        children: [
          // Benefits Section
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Why Choose Us?',
                style: TextStyle(
                  fontSize: 24, // Adjust font size as needed
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Adjust color as needed
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Skill Factorial is among top-rated ed-tech companies providing Online Workshops with Certificates to the working professionals.\n\nStarting from Artificial Intelligence Online Courses for beginners, we have expanded our array to MS Excel Workshops, Power BI workshops, and MS PowerPoint Workshops.',
                style: TextStyle(
                  fontSize: 16, // Adjust font size as needed
                  color: Colors.black, // Adjust color as needed
                ),
                textAlign: TextAlign.center, // Center the text
              ),
              SizedBox(height: 24),
              BenefitItem(
                  icon: Icons.leaderboard,
                  text: '100k+ Professionals Enrolled in our Workshops'),
              BenefitItem(
                  icon: Icons.group, text: 'Learn from IIT Kanpur Alumni'),
              BenefitItem(
                  icon: Icons.book,
                  text: 'Get Workshop Participation Certificate'),
            ],
          ),
          SizedBox(height: 32), // Space before the question mark image
        ],
      ),
    );
  }
}

class BenefitItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const BenefitItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.green), // Customize icon color
        const SizedBox(height: 8),
        Text(
          text,
          style: const TextStyle(
            color: Colors.black, // Customize text color
          ),
          textAlign: TextAlign.center,
        ),
        Divider(),
      ],
    );
  }
}
