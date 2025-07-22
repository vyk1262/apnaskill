import 'package:flutter/material.dart';

import '../common_widgets/cached_network_image_widget.dart';

Widget buildHeroSection(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Theme.of(context).colorScheme.primary,
          Theme.of(context).colorScheme.secondary,
        ],
      ),
    ),
    child: Column(
      children: [
        const SizedBox(height: 20),
        Text(
          '1-Month Python Virtual Internship',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 10,
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(2, 2),
              )
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Text(
          'Transform from beginner to job-ready Python developer in just 30 days',
          style: TextStyle(
            fontSize: 22,
            color: Colors.white.withOpacity(0.9),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 20,
          runSpacing: 15,
          children: [
            _buildFeaturePill(Icons.schedule, '1 Hour/Day'),
            _buildFeaturePill(Icons.verified_user, 'Industry Mentors'),
            _buildFeaturePill(Icons.work, 'Real Projects'),
            _buildFeaturePill(Icons.laptop_chromebook, 'Flexible Schedule'),
          ],
        ),
        const SizedBox(height: 40),
      ],
    ),
  );
}

Widget _buildFeaturePill(IconData icon, String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.15),
      borderRadius: BorderRadius.circular(30),
      border: Border.all(color: Colors.white.withOpacity(0.3)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 18),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    ),
  );
}

Widget buildBenefitsSection(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
    color: Colors.grey[50],
    child: Column(
      children: [
        Text(
          'Why Join This Internship?',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 25,
          runSpacing: 25,
          children: [
            _buildBenefitCard(
              Icons.rocket_launch,
              'Career Boost',
              'Add professional experience to your resume',
              Colors.blue[100]!,
            ),
            _buildBenefitCard(
              Icons.code,
              'Hands-on Learning',
              'Build 4 real-world Python projects',
              Colors.green[100]!,
            ),
            _buildBenefitCard(
              Icons.people,
              'Mentor Support',
              'Get guidance from industry experts',
              Colors.orange[100]!,
            ),
            _buildBenefitCard(
              Icons.verified,
              'Certificate',
              'Earn a verifiable completion certificate',
              Colors.purple[100]!,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildBenefitCard(
    IconData icon, String title, String description, Color bgColor) {
  return Container(
    width: 280,
    padding: const EdgeInsets.all(25),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 36, color: Colors.blue[800]),
        ),
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
          ),
        ),
      ],
    ),
  );
}

Widget buildCertificateSection(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
    color: Colors.grey[50],
    child: Column(
      children: [
        Text(
          'Industry-Recognized Certificate',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Showcase your skills to employers',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
        const SizedBox(height: 40),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: const CachedNetworkImageWidget(
              imageUrl: "https://i.ibb.co/S4pwHMDr/javascript.png",
              width: double.infinity,
              fit: BoxFit.contain,
              errorWidget: Icon(Icons.broken_image),
            ),
          ),
        ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 20,
          runSpacing: 15,
          alignment: WrapAlignment.center,
          children: [
            _buildCertificateFeature('Verifiable Online'),
            _buildCertificateFeature('Share on LinkedIn'),
            _buildCertificateFeature('Add to Resume'),
            _buildCertificateFeature('Company Recognition'),
          ],
        ),
      ],
    ),
  );
}

Widget _buildCertificateFeature(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.blue[100],
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check_circle, color: Colors.green[700], size: 18),
        const SizedBox(width: 8),
        Text(text),
      ],
    ),
  );
}

Widget buildTestimonialSection(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
    child: Column(
      children: [
        Text(
          'What Our Students Say',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const SizedBox(height: 40),
        SizedBox(
          height: 220,
          child: PageView(
            children: [
              _buildTestimonialCard(
                'Rahul Sharma',
                'This internship transformed my Python skills. I built 4 real projects that helped me land my first developer job!',
              ),
              _buildTestimonialCard(
                'Priya Patel',
                'The daily structured learning made it easy to follow. Mentors were always available to help. Highly recommended!',
              ),
              _buildTestimonialCard(
                'Amit Singh',
                'Best investment in my career. The certificate helped me stand out in interviews and negotiate a better salary.',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildTestimonialCard(String name, String text) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    padding: const EdgeInsets.all(30),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 20,
          offset: const Offset(0, 10),
        )
      ],
    ),
    child: Column(
      children: [
        const Icon(Icons.format_quote, size: 40, color: Colors.grey),
        const SizedBox(height: 20),
        Text(
          text,
          style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Text(
          name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ],
    ),
  );
}
