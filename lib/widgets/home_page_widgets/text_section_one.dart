import 'package:flutter/material.dart';

import '../../constants/colors.dart';

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
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(height: 16),
          Text(
            'What YOU will do?',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
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
                style: TextStyle(fontSize: 18, color: AppColors.secondaryColor),
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
                style: TextStyle(fontSize: 18, color: AppColors.secondaryColor),
              ),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

class TextSectionThree extends StatelessWidget {
  const TextSectionThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Text(
            "Welcome to the World of Practice",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.black45,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Kickstart Your Career Journey with Practice, practice, practice ...",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black45,
            ),
          ),
          SizedBox(height: 16),
          Text(
            "From Novice to Expert: The Transformative Power of Practice",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }
}

class TextSectionFour extends StatelessWidget {
  const TextSectionFour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 40, 0, 0),
      child: Text(
        "Designed to shape you into a highly skilled and accomplished professional in any field. with Practice ...",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
