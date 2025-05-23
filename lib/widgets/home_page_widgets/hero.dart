import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_factorial/constants/colors.dart';
import 'package:skill_factorial/widgets/cached_network_image_widget.dart';
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
                newMethodTwo(context),
                const SizedBox(height: 20),
                buildCtaButton(
                  text: 'Start Testing Your Skills',
                  onPressed: () => context.go('/login'),
                  bgColor: AppColors.primaryColor,
                  fgColor: Colors.white,
                ),
              ],
            ),
          )
        : Column(
            children: [
              Expanded(
                flex: 1,
                child: newMethodTwo(context),
              ),
              const SizedBox(height: 20),
              buildCtaButton(
                text: 'Start Testing Your Skills',
                onPressed: () => context.go('/login'),
                bgColor: AppColors.primaryColor,
                fgColor: Colors.white,
              ),
            ],
          );
  }

  Column newMethodTwo(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CachedNetworkImageWidget(
          imageUrl: 'https://i.ibb.co/SDM6mLJB/sf-home-2.png',
          errorWidget: Icon(Icons.broken_image),
        ),
      ],
    );
  }
}
