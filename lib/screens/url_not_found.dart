import 'package:flutter/material.dart';
// removed go_router usage - will use Navigator
import 'package:skill_factorial/screens/courses_home.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('404 - Not Found')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const QuizListHome()),
            );
          },
          child: const Text('Go to Home'),
        ),
      ),
    );
  }
}
