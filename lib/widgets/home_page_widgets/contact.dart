import 'package:flutter/material.dart';

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
