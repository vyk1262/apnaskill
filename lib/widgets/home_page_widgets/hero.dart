import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_factorial/widgets/grid_dot_paint.dart';

import 'cta_button.dart';

class HeroWidget extends StatelessWidget {
  const HeroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: GridDotsBackground(
        child: Center(
          child: heroData(context),
        ),
      ),
    );
  }

  Widget heroData(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomColorizeAnimatedText(
          text: 'Expand Your Knowledge Through Practice With Quizzes',
          colors: [
            Colors.white,
            Colors.blue,
            Colors.deepPurple,
          ],
        ),
        const SizedBox(height: 20),
        Text(
          "Learn",
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width > 700 ? 44 : 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "Test",
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width > 700 ? 44 : 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "Grow",
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width > 700 ? 44 : 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const CustomTypewriterAnimatedText(
          text: 'Expand Your Knowledge Through Practice With Quizzes',
          color: Colors.deepPurple,
        ),
        const SizedBox(height: 20),
        buildCtaButton(
          text: 'Start Learning',
          onPressed: () => context.go('/login'),
        ),
        const SizedBox(height: 20),
        _buildContactButton(context),
      ],
    );
  }

  Widget _buildContactButton(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: const TextStyle(fontSize: 16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.call),
          const SizedBox(width: 8),
          Text(
            "Call Us : 8175989767",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: MediaQuery.of(context).size.width > 700 ? 20 : 16,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTypewriterAnimatedText extends StatelessWidget {
  final String text;
  final Color color;

  const CustomTypewriterAnimatedText({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          text,
          textStyle: TextStyle(
            fontSize: MediaQuery.of(context).size.width > 700 ? 44 : 32,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          speed: const Duration(milliseconds: 100),
        ),
      ],
      totalRepeatCount: 10,
      pause: const Duration(milliseconds: 1000),
      displayFullTextOnTap: true,
      stopPauseOnTap: true,
    );
  }
}

class CustomColorizeAnimatedText extends StatelessWidget {
  final String text;
  final List<Color> colors;

  const CustomColorizeAnimatedText({
    super.key,
    required this.text,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        ColorizeAnimatedText(
          text,
          textStyle: TextStyle(
            fontSize: MediaQuery.of(context).size.width > 700 ? 44 : 32,
            fontWeight: FontWeight.bold,
          ),
          colors: colors,
          speed: const Duration(milliseconds: 100),
        ),
      ],
      totalRepeatCount: 10,
      pause: const Duration(milliseconds: 1000),
      displayFullTextOnTap: true,
      stopPauseOnTap: true,
    );
  }
}
