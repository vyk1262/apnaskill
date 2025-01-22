import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Icon(
              icon,
              size: 48,
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.secondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {
                // Add action here
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.blue),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: Text("More info"),
            ),
          ],
        ),
      ),
    );
  }
}
