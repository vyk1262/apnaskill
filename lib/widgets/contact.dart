import 'package:apnaskill/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          SizedBox(height: 40),
          Text(
            'Contact Us',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ContactCard(
                icon: Icons.email,
                title: 'Email',
                text: 'apnaskill.in@gmail.com',
              ),
              ContactCard(
                icon: Icons.phone,
                title: 'Phone',
                text: '+91 8175989767',
              ),
              ContactCard(
                icon: Icons.message_rounded,
                title: 'Whatsapp',
                text: '+91 8175989767',
              ),
              // Uncomment the following if you want to display the location
              // ContactCard(
              //   icon: Icons.location_on,
              //   title: 'Location',
              //   text: 'Apnaskill, Near to Archid Tower,\nBaner, Pune-422045',
              // ),
            ],
          ),
          SizedBox(height: 16), // Optional spacing
        ],
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  final Widget? child;

  const ContactCard({
    required this.icon,
    required this.title,
    required this.text,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Add some corner rounding
      ),
      elevation: 4.0, // Add a subtle shadow for visual separation
      margin: const EdgeInsets.symmetric(vertical: 10.0), // Add spacing
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding for content
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min, // Content fits width
              children: [
                Icon(icon, size: 40.0),
                const SizedBox(width: 16.0), // Spacing between icon and text
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(text),
                  ],
                ),
              ],
            ),
            if (child != null) child!,
          ],
        ),
      ),
    );
  }
}
