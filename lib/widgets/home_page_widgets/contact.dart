import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:skill_factorial/constants/colors.dart'; // Import the package

class ContactCard extends StatelessWidget {
  const ContactCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine if the current device is considered 'mobile' based on screen width
    final bool isMobile = MediaQuery.of(context).size.width < 850;

    final List<Map<String, dynamic>> contactData = [
      {
        'icon': Icons.email,
        'title': 'Email',
        'text': 'skillfactorial@gmail.com',
      },
      // {'icon': Icons.phone, 'title': 'Phone', 'text': '+91 8778605825'},
      // {
      //   'icon': Icons.message_rounded,
      //   'title': 'Whatsapp',
      //   'text': '+91 8778605825',
      // },
      {
        'icon': Icons.location_on,
        'title': 'Location',
        'text': 'Skill Factorial, Near to Archid Tower, Baner, Pune-422045',
      }
    ];

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 8.0,
      margin: const EdgeInsets.all(16), // Added margin for better spacing
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: AppColors.gradientPrimary,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: isMobile
            ? _buildMobileLayout(contactData) // Use Column for mobile
            : _buildDesktopLayout(contactData), // Use Row for desktop
      ),
    );
  }

  // Helper method for desktop layout (Row)
  Widget _buildDesktopLayout(List<Map<String, dynamic>> contactData) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: CachedNetworkImage(
            imageUrl: 'https://i.ibb.co/wFTXw9s9/contact.png',
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.error)),
            fit: BoxFit.contain, // Use contain for desktop
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildContactDetails(contactData),
            ),
          ),
        ),
      ],
    );
  }

  // Helper method for mobile layout (Column)
  Widget _buildMobileLayout(List<Map<String, dynamic>> contactData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: SizedBox(
            height: 150, // Fixed height for image on mobile
            child: CachedNetworkImage(
              imageUrl: 'https://i.ibb.co/wFTXw9s9/contact.png',
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
              fit: BoxFit.contain, // Use contain for mobile
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildContactDetails(contactData),
        ),
      ],
    );
  }

  // Helper method to build the common contact details list
  List<Widget> _buildContactDetails(List<Map<String, dynamic>> contactData) {
    return contactData.map((data) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                data['icon'] as IconData,
                color: Colors.white,
                size: 40.0,
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['title'] as String,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    data['text'] as String,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
