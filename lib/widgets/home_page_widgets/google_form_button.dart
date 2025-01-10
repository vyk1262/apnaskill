import 'package:apnaskill/constants/colors.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

class GoogleFormButton extends StatelessWidget {
  const GoogleFormButton({Key? key}) : super(key: key);
  void openUrl(String url) {
    html.window.open(url, '_blank');
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        const url = 'https://forms.gle/gqaYp61V1B4XQPwu7';
        openUrl(url);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text('Register here'),
    );
  }
}
