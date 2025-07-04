import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Assuming go_router is used for navigation
import 'package:url_launcher/url_launcher.dart';

import '../constants/colors.dart'; // To open external links like Google Forms
import 'package:skill_factorial/screens/common_widgets/custom_app_bar.dart';

import 'common_widgets/cached_network_image_widget.dart'; // Assuming a custom app bar

class VirtualInternship extends StatefulWidget {
  const VirtualInternship({Key? key}) : super(key: key);

  @override
  State<VirtualInternship> createState() => _VirtualInternshipState();
}

class _VirtualInternshipState extends State<VirtualInternship> {
  final String googleFormLink = 'https://forms.gle/YOUR_GOOGLE_FORM_LINK_HERE';
  List<Map<String, dynamic>> dailyPlan = []; // Initialize as an empty list

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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Skill Factorial: 1-Month Python Virtual Internship',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Embark on a hands-on journey to master essential tech skills. Build real-world projects and boost your career.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              _buildSectionTitle(context, 'Daily Learning Plan'),
              const SizedBox(height: 16),
              _buildDailyPlanGrid(context),
              const SizedBox(height: 24),
              _buildCenteredSection(context, title: '--- Register Now ---'),
              const SizedBox(height: 16),
              _buildCenteredSection(context, title: 'Just Rupees: 499/-'),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => _launchURL(googleFormLink),
                icon: const Icon(Icons.app_registration),
                label: const Text('Register via Google Form',
                    style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                  shadowColor:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 32),
              _buildCenteredSection(
                context,
                title: '--- Internship Certificate ---',
                content:
                    'Get a verified internship certificate from Skill Factorial upon successful completion.',
              ),
              const CachedNetworkImageWidget(
                imageUrl: "https://i.ibb.co/S4pwHMDr/javascript.png",
                width: double.infinity,
                fit: BoxFit.cover,
                errorWidget: Icon(Icons.broken_image),
              ),
              const SizedBox(height: 32),
              _buildCenteredSection(context, title: '--- Register Now ---'),
              const SizedBox(height: 16),
              _buildCenteredSection(context, title: 'Just Rupees: 499/-'),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => _launchURL(googleFormLink),
                icon: const Icon(Icons.app_registration),
                label: const Text('Register via Google Form',
                    style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                  shadowColor:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Center(
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildDailyPlanGrid(BuildContext context) {
    // Determine number of columns based on screen width
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount;
    if (screenWidth < 600) {
      crossAxisCount = 1; // 1 column on small screens (e.g., phones)
    } else if (screenWidth < 900) {
      crossAxisCount = 2; // 2 columns on medium screens (e.g., tablets)
    } else {
      crossAxisCount = 3; // 3 columns on large screens (e.g., desktops)
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: dailyPlan.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: (screenWidth < 600)
            ? 3.0
            : 2.5, // Adjust aspect ratio for better look
      ),
      itemBuilder: (context, index) {
        final item = dailyPlan[index];
        return _buildDailyPlanGridItem(
          context,
          day: item['day'],
          title: item['title'],
          description: item['description'],
        );
      },
    );
  }

  Widget _buildDailyPlanGridItem(BuildContext context,
      {required int day, required String title, required String description}) {
    // ValueNotifier to manage hover state for each item
    final ValueNotifier<bool> _isHovering = ValueNotifier<bool>(false);

    return MouseRegion(
      onEnter: (_) => _isHovering.value = true,
      onExit: (_) => _isHovering.value = false,
      child: ValueListenableBuilder<bool>(
        valueListenable: _isHovering,
        builder: (context, isHovering, child) {
          return Card(
            margin:
                EdgeInsets.zero, // No external margin, GridView handles spacing
            elevation: isHovering ? 8 : 3, // Increased elevation on hover
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: isHovering
                    ? Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.8) // Highlight border on hover
                    : Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                width: isHovering ? 2 : 1, // Thicker border on hover
              ),
            ),
            // Optional: Add a slight scale animation on hover
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              transform: Matrix4.identity()..scale(isHovering ? 1.02 : 1.0),
              curve: Curves.easeOut,
              padding: const EdgeInsets.all(
                  16.0), // Increased padding for better content spacing
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Text(
                          '$day',
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 18, // Slightly larger title
                            fontWeight: FontWeight.w700, // Bolder title
                            color: isHovering
                                ? Theme.of(context).colorScheme.primary
                                : Colors.black87, // Title color change on hover
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12), // Increased spacing
                  Expanded(
                    // Use Expanded for description to fill remaining space
                    child: Text(
                      description,
                      style: const TextStyle(
                          fontSize: 15,
                          color: Colors
                              .black54), // Slightly larger description font
                      maxLines: 4, // Limit lines for descriptions in grid items
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCenteredSection(BuildContext context,
      {required String title, String content = ''}) {
    return Center(
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
            textAlign: TextAlign.center,
          ),
          if (content.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              content,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ]
        ],
      ),
    );
  }
}
