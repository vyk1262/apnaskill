import 'package:apnaskill/constants/colors.dart';
import 'package:apnaskill/widgets/static_river_paint.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

class MainTextInfo extends StatelessWidget {
  const MainTextInfo({Key? key}) : super(key: key);

  void openUrl(String url) {
    html.window.open(url, '_blank');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 16.0), // Padding for content
      child: Column(
        children: [
          // Top Row with Image and Text
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Image.asset(
                    'assets/apna-bg.png',
                    height: 350,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Build Confidence and Land Your Dream Job with Practice ...",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'What do YOU get?',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        Icon(Icons.check_circle,
                            size: 48, color: AppColors.primaryColor),
                        SizedBox(width: 16),
                        Text(
                          'Knowledge ...',
                          style: TextStyle(fontSize: 20, color: Colors.black87),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          const url = 'https://forms.gle/gqaYp61V1B4XQPwu7';
                          openUrl(url);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 14),
                          textStyle: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Register here'),
                      ),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),

          // Spacing between sections
          SizedBox(height: 24),

          // Bottom Section with Texts and River Paint
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Breaking Through the Job Market: Overcoming the Experience Barrier",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 16),
              Text(
                "Kickstart Your Career Journey with Practice, practice, practice ...",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 16),
              Text(
                "From Novice to Expert: The Transformative Power of Practice",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 16),
              CustomPaint(
                painter: StaticRiverStyle(),
                size: Size(double.infinity, 200),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
