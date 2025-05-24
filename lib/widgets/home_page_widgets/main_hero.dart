import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_factorial/constants/colors.dart';
import '../cached_network_image_widget.dart';
import 'cta_button.dart';

class MainHero extends StatelessWidget {
  const MainHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.gradientPrimaryMain,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Text(
              'Transform Your Future with Skill Factorial',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Join our platform to learn and upskill with quizzes, ',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            buildCtaButton(
              text: 'Get Started Now',
              onPressed: () => context.go('/login'),
              bgColor: Colors.white,
              fgColor: Colors.blue.shade800,
            ),
            // const SizedBox(height: 48),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     _buildStatCard('10K+', 'Active Learners'),
            //     _buildStatCard('500+', 'Expert Mentors'),
            //     _buildStatCard('100+', 'Practice Tests'),
            //   ],
            // ),
            CachedNetworkImageWidget(
              imageUrl: 'https://i.ibb.co/TMTJDqGC/sf-hero-a.png',
              errorWidget: Icon(Icons.broken_image),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String number, String label) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text(
            number,
            style: const TextStyle(
              color: AppColors.surfaceColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: AppColors.surfaceColor.withOpacity(0.8),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
