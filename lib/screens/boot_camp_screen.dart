import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_factorial/screens/common_widgets/footer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/bootcamp_data.dart';
import 'common_widgets/benefit_cart.dart';
import 'common_widgets/certificate_feature.dart';
import 'common_widgets/feature_pill.dart';
import '../constants/colors.dart';
import 'common_widgets/custom_app_bar.dart';
import 'common_widgets/cached_network_image_widget.dart';
import 'common_widgets/weekly_syllabus_card.dart';
import 'home_page_widgets/cta_button.dart';
import 'home_page_widgets/why.dart';

class VirtualBootCamp extends StatefulWidget {
  const VirtualBootCamp({Key? key}) : super(key: key);

  @override
  State<VirtualBootCamp> createState() => _VirtualBootCampState();
}

class _VirtualBootCampState extends State<VirtualBootCamp> {
  final String googleFormLink = 'https://forms.gle/YOUR_GOOGLE_FORM_LINK_HERE';

  String selectedCourse = "Python"; // default → Python

  final courses = ["Python", "SQL", "Power BI", "DSA"];
  // You can keep this in a constants file if you want

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
            WhyChooseUs(
              title: "1-Month Python Virtual Internship",
              description:
                  "Transform from beginner to job-ready Python developer in 30 days",
              benefits: [
                Benefit(icon: Icons.schedule, text: "1 Hour/Day"),
                Benefit(icon: Icons.people, text: "Industry Mentors"),
                Benefit(icon: Icons.work, text: "Real Projects"),
                Benefit(icon: Icons.laptop, text: "Flexible Schedule"),
              ],
            ),
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
            const SizedBox(height: 30),
            buildCtaButton(
              text: 'ENROLL NOW FOR ₹499',
              onPressed: () => _launchURL(googleFormLink),
              bgColor: Colors.black,
              fgColor: Colors.white,
            ),
            buildDailyPlanSection(context),
            const SizedBox(height: 40),
            Text(
              "Choose Your Track",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            ToggleButtons(
              isSelected: courses.map((c) => c == selectedCourse).toList(),
              onPressed: (index) {
                setState(() {
                  selectedCourse = courses[index];
                });
              },
              borderRadius: BorderRadius.circular(10),
              fillColor: Colors.blue.shade100,
              selectedColor: Colors.blue.shade800,
              color: Colors.grey.shade700,
              constraints: const BoxConstraints(minHeight: 40, minWidth: 80),
              children: courses
                  .map((c) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(c),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 30),
            Center(
              child: Wrap(
                spacing: 10,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: bootcampSyllabus[selectedCourse]!
                    .map((week) => WeekSyllabusCard(
                          title: week["title"] as String,
                          syllabusItems:
                              List<String>.from(week["items"] as List),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 40),
            Footer(),
          ],
        ),
      ),
    );
  }

  Widget buildDailyPlanSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(top: 40),
      child: Column(
        children: [
          Text(
            'Your 30 Days / 4 Weeks Journey',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Structured learning path with daily milestones',
            style: TextStyle(fontSize: 18, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.checklist,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 30,
                    ),
                    title: Text(
                      'Solve 3-4 problems daily',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    subtitle: const Text(
                      'Complete 25 problems weekly and 100 problems in total.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const Divider(),
                  // learn 1 hour a day
                  ListTile(
                      leading: Icon(
                        Icons.timer,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 30,
                      ),
                      title: Text(
                        'Learn 1 hour a day',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      subtitle: const Text(
                        'Practice coding every day to reinforce your understanding.',
                        style: TextStyle(color: Colors.grey),
                      )),
                  const Divider(),
                  // if you are student become job ready
                  ListTile(
                    leading: Icon(
                      Icons.book,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 30,
                    ),
                    title: Text(
                      'If you are student become job ready',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    subtitle: const Text(
                      'Learn Python, SQL, Power BI, and DSA in 30 days.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const Divider(),
                  // if you are a working professional grow your salary with new skills
                  ListTile(
                    leading: Icon(
                      Icons.monetization_on,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 30,
                    ),
                    title: Text(
                      'If you are a working professional grow your salary with new skills',
                    ),
                    subtitle: const Text(
                      'Build 4 real-world projects to showcase your skills.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.support_agent,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 30,
                    ),
                    title: Text(
                      'Weekly Doubts Session',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    subtitle: const Text(
                      'Join our live doubts clearance session every Thursday at 7:30 PM.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
