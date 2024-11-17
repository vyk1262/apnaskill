import 'package:apnaskill/paints/river.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

class MainTextInfo extends StatelessWidget {
  const MainTextInfo({Key? key}) : super(key: key);
  void openUrl(String url) {
    html.window.open(url, '_blank');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Image.asset(
                  'assets/apna-bg.png',
                  // width: 100,
                  height: 400,
                  fit: BoxFit.contain,
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text(
                      "Build Confidence and Land Your Dream Job with Practice ...",
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      'What do YOU get?',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle, size: 48),
                        SizedBox(width: 16),
                        Text(
                          'Knowledge ...',
                          style: TextStyle(fontSize: 18),
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
                        child: const Text('Register here'),
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
              // Expanded(
              //   flex: 1,
              //   child: Image.asset(
              //     'assets/apna-bg.png',
              //     // width: 100,
              //     height: 400,
              //     fit: BoxFit.contain,
              //   ),
              // ),
            ],
          ),
          SizedBox(height: 16),
          Column(
            children: [
              Container(
                // color: Colors.blue,
                child: Text(
                  "Breaking Through the Job Market: Overcoming the Experience Barrier",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Container(
                // color: Colors.blue,
                child: Text(
                  "Kickstart Your Career Journey with Practice, practice, practice ...",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Container(
                // color: Colors.blue,
                child: Text(
                  "From Novice to Expert: The Transformative Power of Practice",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              CustomPaint(
                painter: StaticRiverStyle(),
                size: Size(double.infinity, 200),
              ),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
