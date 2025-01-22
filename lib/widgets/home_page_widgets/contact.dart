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
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Add consistent padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Center-align content
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 40.0),
            const SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center, // Center-align text
            ),
            const SizedBox(height: 4.0),
            Text(
              text,
              textAlign: TextAlign.center, // Center-align text
            ),
            if (child != null) ...[
              const SizedBox(height: 8.0),
              child!,
            ],
          ],
        ),
      ),
    );
  }
}
