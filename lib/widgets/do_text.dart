import 'package:flutter/material.dart';

class DoTextInfo extends StatelessWidget {
  const DoTextInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Expanded(
          flex: 1,
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
                    'Assignments',
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
        ),
        Expanded(
          flex: 1,
          child: Image.asset(
            'assets/it2.png',
            // width: double.infinity,
            // height: 550,
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}
