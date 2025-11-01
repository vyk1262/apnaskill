import 'package:flutter/material.dart';

class ContactInfoSection extends StatelessWidget {
  // Data for the Contact Info Section
  final Map<String, dynamic> pageData = const {
    'contactInfo': {
      'title': "Get in Touch with Us",
      'details': [
        {
          'emoji': "📧",
          'title': "Email",
          'text': "skillfactorial@gmail.com",
        },
        {
          'emoji': "📞",
          'title': "Phone",
          'text': "+91 8778605825",
        },
        {
          'emoji': "📱",
          'title': "Whatsapp",
          'text': "+91 9999999999",
        },
        {
          'emoji': "📍",
          'title': "Location",
          'text': "Skill Factorial, Near to Archid Tower, Baner, Pune-422045",
        },
      ],
    },
  };

  const ContactInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final details = pageData['contactInfo']['details'] as List;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 64.0),
      color: const Color(0xFF1f2937), // Matches the dark background
      child: Center(
        child: Column(
          children: [
            Text(
              pageData['contactInfo']['title']!,
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
                crossAxisSpacing: 24.0,
                mainAxisSpacing: 24.0,
                childAspectRatio: 1.2,
              ),
              itemCount: details.length,
              itemBuilder: (context, index) {
                final detail = details[index];
                return _buildContactCard(detail);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(Map<String, String> detail) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1f2937), // `bg-gray-800` from the CSS
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            detail['emoji']!,
            style: const TextStyle(
              fontSize: 48.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            detail['title']!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            detail['text']!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16.0,
              color: Color(0xFF9ca3af), // Gray 400
            ),
          ),
        ],
      ),
    );
  }
}
