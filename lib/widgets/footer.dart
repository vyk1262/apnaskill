import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_factorial/home.dart';
import 'package:skill_factorial/screens/syllabus_view.dart';
import 'package:skill_factorial/screens/register.dart';
import 'package:skill_factorial/widgets/home_page_widgets/cta_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/faqs.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              buildCtaButton(
                text: "Faqs",
                onPressed: () => context.go('/faqs'),
              ),
              buildCtaButton(text: "Home", onPressed: () => context.go('/')),
              buildCtaButton(
                  text: "Quizzes", onPressed: () => context.go('/quizzes')),
              buildCtaButton(
                  text: "Login", onPressed: () => context.go('/login')),
              buildCtaButton(
                  text: "Blogs", onPressed: () => context.go('/blogs'))
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

  Widget _buildFooterLink(
      BuildContext context, String label, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIconButton(IconData icon, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: IconButton(
        onPressed: () {
          // Open external social media link
          _openSocialMediaLink(url);
        },
        icon: FaIcon(icon, color: Colors.white),
      ),
    );
  }

  void _openSocialMediaLink(String url) async {
    // Add logic to open URL, e.g., using the 'url_launcher' package
    // Example: await launch(url);
  }
}

Widget _buildNavLink(String text) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueAccent, Colors.purpleAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {},
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}
