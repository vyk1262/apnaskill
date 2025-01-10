import 'package:flutter/material.dart';

class TextSectionOne extends StatelessWidget {
  const TextSectionOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Empowering Growth Through Skill Development",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            "At Skill Factorial, located in the heart of Hyderabad, we are dedicated to transforming the educational landscape through innovative skill development programs. Our mission is to empower individuals with the practical skills necessary for success in today's dynamic job market. We believe in a hands-on approach that bridges the gap between theoretical knowledge and real-world application. Join us on a journey of lifelong learning and professional growth.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

class TextSectionTwo extends StatelessWidget {
  const TextSectionTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(height: 16),
          Text(
            'What YOU will do?',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.task_alt_rounded, size: 48),
              SizedBox(width: 16),
              Text(
                'Quizzes',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.task_alt_rounded, size: 48),
              SizedBox(width: 16),
              Text(
                'Projects',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
