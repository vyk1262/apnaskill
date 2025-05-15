import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Import the package

class ContactCard extends StatelessWidget {
  const ContactCard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> contactData = [
      {
        'icon': Icons.email,
        'title': 'Email',
        'text': 'support@skillfactorial.com',
      },
      {'icon': Icons.phone, 'title': 'Phone', 'text': '+91 8175989767'},
      {
        'icon': Icons.message_rounded,
        'title': 'Whatsapp',
        'text': '+91 8175989767',
      },
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
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF10B981),
              const Color(0xFF8B5CF6).withOpacity(0.8)
            ],
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center, // Changed to start
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl:
                    'https://i.ibb.co/wFTXw9s9/contact.png', // Corrected URL
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error)),
                fit: BoxFit.cover, // Ensure the image fits within the container
              ),
            ),
            Expanded(
              // Added Expanded
              child: Padding(
                padding:
                    const EdgeInsets.only(right: 16.0), // Added right padding
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Added this line
                  children: contactData.map((data) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start, //added
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
                            // Use Expanded here
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
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
