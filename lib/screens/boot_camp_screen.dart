import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/colors.dart';
import 'boot_camp_widgets/boot_camp_hero.dart';
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
    _loadDailyPlan();
  }

  Future<void> _loadDailyPlan() async {
    try {
      final String response = await DefaultAssetBundle.of(context)
          .loadString('assets/daily_plan.json');
      final List<dynamic> data = json.decode(response);
      setState(() {
        dailyPlan = data.cast<Map<String, dynamic>>();
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load daily plan: $e')),
        );
      }
      print('Error loading daily plan: $e');
    }
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
            // Benefits Section
            buildBenefitsSection(context),
            // Daily Plan Section
            _buildDailyPlanSection(context),
            // Pricing Section
            buildPricingSection(context),
            // Certificate Section
            buildCertificateSection(context),
            // Testimonial Section
            buildTestimonialSection(context),
            // Final CTA
            buildFinalCTASection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyPlanSection(BuildContext context) {
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
          ..._buildDailyPlanTimeline(),
        ],
      ),
    );
  }

  List<Widget> _buildDailyPlanTimeline() {
    return List.generate(dailyPlan.length, (index) {
      final item = dailyPlan[index];
      final isEven = index.isEven;

      return Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isEven) ...[
              Expanded(
                child: _buildDayContent(
                  day: item['day'],
                  title: item['title'],
                  description: item['description'],
                  alignment: CrossAxisAlignment.end,
                  textAlignment: TextAlign.right,
                ),
              ),
              _buildTimelineConnector(index),
              _buildDayIndicator(item['day']),
            ],
            if (!isEven) ...[
              _buildDayIndicator(item['day']),
              _buildTimelineConnector(index),
              Expanded(
                child: _buildDayContent(
                  day: item['day'],
                  title: item['title'],
                  description: item['description'],
                  alignment: CrossAxisAlignment.start,
                  textAlignment: TextAlign.left,
                ),
              ),
            ],
          ],
        ),
      );
    });
  }

  Widget _buildDayIndicator(int day) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          'Day $day',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineConnector(int index) {
    return Column(
      children: [
        Container(
          width: 2,
          height: 20,
          color: Theme.of(context).colorScheme.secondary,
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            shape: BoxShape.circle,
          ),
        ),
        if (index != dailyPlan.length - 1)
          Container(
            width: 2,
            height: 60,
            color: Theme.of(context).colorScheme.secondary,
          ),
      ],
    );
  }

  Widget _buildDayContent({
    required int day,
    required String title,
    required String description,
    required CrossAxisAlignment alignment,
    required TextAlign textAlignment,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Text(
            title,
            textAlign: textAlignment,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: textAlignment,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
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
                  onPressed: () => _launchURL(googleFormLink),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 8,
                    shadowColor: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.5),
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

  Widget buildFinalCTASection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
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
