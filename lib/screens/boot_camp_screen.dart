import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'common_widgets/benefit_cart.dart';
import 'common_widgets/certificate_feature.dart';
import 'common_widgets/feature_pill.dart';
import '../constants/colors.dart';
import 'common_widgets/custom_app_bar.dart';
import 'common_widgets/cached_network_image_widget.dart';

class VirtualBootCamp extends StatefulWidget {
  const VirtualBootCamp({Key? key}) : super(key: key);

  @override
  State<VirtualBootCamp> createState() => _VirtualBootCampState();
}

class _VirtualBootCampState extends State<VirtualBootCamp> {
  final String googleFormLink = 'https://forms.gle/YOUR_GOOGLE_FORM_LINK_HERE';
  List<Map<String, dynamic>> dailyPlan = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $url')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            buildHeroSection(context),
            // Daily Plan Section
            buildDailyPlanSection(context),
            // Pricing Section
            buildPricingSection(context),
            // Final CTA
            buildFinalCTASection(context),
          ],
        ),
      ),
    );
  }

  Widget buildDailyPlanSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        children: [
          Text(
            'Your 30-Day Journey',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Structured learning path with daily milestones',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 40),
          // solve 25 problems weekly and complete 100 problems or make it 3-4 problems a day
          const Text(
            'Solve 25 problems weekly and complete 100 problems or make it 3-4 problems a day',
            style: TextStyle(fontSize: 18, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          // doubts clearance session every week Thursdays at 7:30 PM
          const Text(
            'Doubts clearance session every week Thursdays at 7:30 PM',
            style: TextStyle(fontSize: 18, color: Colors.grey),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Widget buildFinalCTASection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      decoration: BoxDecoration(
        gradient: AppColors.gradientPrimary,
      ),
      child: Column(
        children: [
          const Text(
            'Ready to Launch Your Tech Career?',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Text(
            'Join 5000+ students who transformed their careers with Skill Factorial',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => _launchURL(googleFormLink),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 8,
              shadowColor: Colors.black.withOpacity(0.3),
            ),
            child: const Text(
              'ENROLL NOW FOR ₹499',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Registration closes in: 2 days 14 hours',
            style: TextStyle(
              fontSize: 16,
              color: Colors.yellow[200],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildHeroSection(BuildContext context) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        decoration: BoxDecoration(
          gradient: AppColors.gradientPrimary,
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              '1-Month Python Virtual Internship',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(2, 2),
                  )
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Transform from beginner to job-ready Python developer in just 30 days',
              style: TextStyle(
                fontSize: 22,
                color: Colors.white.withOpacity(0.9),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Wrap(
              spacing: 20,
              runSpacing: 15,
              children: [
                buildFeaturePill(Icons.schedule, '1 Hour/Day'),
                buildFeaturePill(Icons.verified_user, 'Industry Mentors'),
                buildFeaturePill(Icons.work, 'Real Projects'),
                buildFeaturePill(Icons.laptop_chromebook, 'Flexible Schedule'),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        color: Colors.grey[50],
        child: Column(
          children: [
            Text(
              'Why Join This Internship?',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 30),
            Wrap(
              spacing: 25,
              runSpacing: 25,
              children: [
                buildBenefitCard(
                  Icons.rocket_launch,
                  'Career Boost',
                  'Add professional experience to your resume',
                  Colors.blue[100]!,
                ),
                buildBenefitCard(
                  Icons.code,
                  'Hands-on Learning',
                  'Build 4 real-world Python projects',
                  Colors.green[100]!,
                ),
                buildBenefitCard(
                  Icons.people,
                  'Mentor Support',
                  'Get guidance from industry experts',
                  Colors.orange[100]!,
                ),
                buildBenefitCard(
                  Icons.verified,
                  'Certificate',
                  'Earn a verifiable completion certificate',
                  Colors.purple[100]!,
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
        color: Colors.grey[50],
        child: Column(
          children: [
            Text(
              'Industry-Recognized Certificate',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Showcase your skills to employers',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImageWidget(
                  imageUrl: "https://i.ibb.co/S4pwHMDr/javascript.png",
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: MediaQuery.of(context).size.width / 1.2,
                  fit: BoxFit.fitWidth,
                  errorWidget: Icon(Icons.broken_image),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Wrap(
              spacing: 20,
              runSpacing: 15,
              alignment: WrapAlignment.center,
              children: [
                buildCertificateFeature('Verifiable Online'),
                buildCertificateFeature('Share on LinkedIn'),
                buildCertificateFeature('Add to Resume'),
                buildCertificateFeature('Company Recognition'),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildPricingSection(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Theme.of(context).colorScheme.primary.withOpacity(0.8),
          Theme.of(context).colorScheme.secondary,
        ],
      ),
    ),
    child: Column(
      children: [
        const Text(
          'Limited Time Offer',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 30,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                'Total Program Fee',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '₹499',
                    style: TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '₹4999',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey[500],
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                '90% OFF - Limited Seats Only!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // _launchURL(googleFormLink),
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 8,
                  shadowColor:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                ),
                child: const Text(
                  'ENROLL NOW',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Registration closes in 3 days',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
