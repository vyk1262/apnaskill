import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_factorial/home.dart';
import 'package:skill_factorial/screens/register.dart';
import 'package:skill_factorial/widgets/home_page_widgets/cta_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/faqs.dart';

class Footer extends StatelessWidget {
  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // Handle the error, e.g., show a SnackBar
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Skill Factorial',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Image.asset(
            'assets/student_home/logo.png',
            width: 100,
            height: 100,
          ),
          const SizedBox(height: 16),
          const Text(
            'Empowering Your Learning Journey',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          Text(
            textAlign: TextAlign.center,
            'Skill Factorial is an online platform dedicated to enhancing learning through practice. We offer a diverse range of quizzes designed to help students and working professionals solidify their knowledge, identify areas for improvement, and gauge their understanding. Our belief is that active engagement and self-assessment are key to effective learning, making Skill Factorial an invaluable resource for anyone looking to master new skills and refine existing ones.',
            style: TextStyle(color: Colors.grey[400], fontSize: 16),
          ),
          const SizedBox(height: 16),

          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              Column(
                children: [
                  buildCtaButton(
                      text: "Home",
                      onPressed: () => context.go('/'),
                      bgColor: Colors.black),
                ],
              ),
              Column(
                children: [
                  buildCtaButton(
                      text: "Quizzes",
                      onPressed: () => context.go('/quizzes'),
                      bgColor: Colors.black),
                ],
              ),
              Column(
                children: [
                  buildCtaButton(
                    text: "Series",
                    onPressed: () => context.go('/series'),
                    bgColor: Colors.black,
                  ),
                ],
              ),
              Column(
                children: [
                  buildCtaButton(
                    text: "Fast Math",
                    onPressed: () => context.go('/fastmath'),
                    bgColor: Colors.black,
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Social Media Links
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIconButton(
                  FontAwesomeIcons.facebook, 'https://facebook.com'),
              _buildSocialIconButton(
                  FontAwesomeIcons.twitter, 'https://twitter.com'),
              _buildSocialIconButton(
                  FontAwesomeIcons.linkedin, 'https://linkedin.com'),
              _buildSocialIconButton(
                  FontAwesomeIcons.instagram, 'https://instagram.com'),
            ],
          ),
          const SizedBox(height: 16),

          // Copyright
          Text(
            '© 2025 Skill Factorial. All rights reserved.',
            style: TextStyle(color: Colors.grey[400], fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIconButton(IconData icon, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: IconButton(
        onPressed: () => _launchUrl(url),
        icon: FaIcon(icon, color: Colors.white),
        tooltip: 'Visit ${Uri.parse(url).host}',
      ),
    );
  }
}
