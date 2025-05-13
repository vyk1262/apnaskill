import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_factorial/constants/colors.dart';
import 'cta_button.dart';

class HeroWidget extends StatefulWidget {
  const HeroWidget({super.key});

  @override
  State<HeroWidget> createState() => _HeroWidgetState();
}

class _HeroWidgetState extends State<HeroWidget> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.5,
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        child: Center(
          child: heroData(context),
        ),
      ),
    );
  }

  Widget heroData(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 850;
    return isMobile
        ? SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                newMethodOne(context),
                newMethodTwo(context),
                const SizedBox(height: 20),
                buildCtaButton(
                    text: 'Start Testing Your Skills',
                    onPressed: () => context.go('/login'),
                    bgColor: Colors.black),
              ],
            ),
          )
        : Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: newMethodOne(context),
                  ),
                  Expanded(
                    flex: 1,
                    child: newMethodTwo(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              buildCtaButton(
                text: 'Start Testing Your Skills',
                onPressed: () => context.go('/login'),
                bgColor: Colors.black,
              ),
            ],
          );
  }

  Column newMethodOne(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.network(
          'https://i.ibb.co/ZpqMW2Pw/sf-home-1.png',
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        ),
      ],
    );
  }

  Column newMethodTwo(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.network(
          'https://i.ibb.co/SDM6mLJB/sf-home-2.png',
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        ),
      ],
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
