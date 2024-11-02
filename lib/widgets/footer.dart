import 'package:apnaskill/constants/colors.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: AppColors.primaryColor,
      width: double.infinity,
      child: Text(
        '© 2024 Apnaskill | All Rights Reserved',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
      ),
    );
  }
}
