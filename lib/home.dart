import 'package:apnaskill/screens/faqs.dart';
import 'package:apnaskill/widgets/home_page_widgets/contact.dart';
import 'package:apnaskill/widgets/home_page_widgets/feature_widget.dart';
import 'package:apnaskill/widgets/footer.dart';
import 'package:apnaskill/widgets/home_page_widgets/main_text.dart';
import 'package:apnaskill/widgets/paint_widgets/square_grid_paint.dart';
import 'package:apnaskill/widgets/home_page_widgets/text_we.dart';
import 'package:apnaskill/widgets/home_page_widgets/success_stories_widget.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> syllabus = [];
  bool isLoading = true;
  final List<String> internshipTexts = [
    "ApnaSkill.in is your gateway to mastering technology. We're passionate about empowering students like YOU with the skills and practical experience needed to excel in your studies.",
    "Struggling to grasp concepts? Practice makes perfect! Quizzes, assignments, and projects are your keys to deeper understanding and confidence.",
    "The academic world can be challenging, but with structured practice through assignments and projects, you're building a solid foundation for success.",
    "Break away from traditional rote learning. Engage with flexible and interactive quizzes, assignments, and projects designed to fit your schedule.",
    "Ready to excel in your subjects? Practical learning through quizzes, assignments, and projects bridges the gap between theory and application, boosting your knowledge and skills."
  ];

  @override
  void initState() {
    super.initState();
  }

  void openUrl(String url) {
    html.window.open(url, '_blank');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 16),
                    MainTextInfo(),
                    const SizedBox(height: 16),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // First Feature
                        FeatureItem(
                          icon: Icons.person,
                          title: "Personalized Learning Programs",
                          description:
                              "Tailored educational experiences designed to meet individual student needs and learning styles.",
                        ),
                        // Second Feature
                        FeatureItem(
                          icon: Icons.lightbulb_outline,
                          title: "Expert-Led Workshops",
                          description:
                              "Interactive sessions with industry experts aimed at skill enhancement and real-world application.",
                        ),
                        // Third Feature
                        FeatureItem(
                          icon: Icons.menu_book,
                          title: "Comprehensive Course Materials",
                          description:
                              "Well-structured resources providing in-depth knowledge across various subjects and disciplines.",
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.purpleAccent, Colors.blueAccent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Text Section
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(
                                        "Empowering Growth Through Skill Development",
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      "At Skill Factorial, located in the heart of Hyderabad, we are dedicated to transforming the educational landscape through innovative skill development programs. Our mission is to empower individuals with the practical skills necessary for success in today's dynamic job market. We believe in a hands-on approach that bridges the gap between theoretical knowledge and real-world application. Join us on a journey of lifelong learning and professional growth.",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Image Section
                            Expanded(
                              flex: 1,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                                child: Image.asset(
                                  'assets/book_shelf.png',
                                  fit: BoxFit.cover,
                                  height: double.infinity,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Stack(
                      children: [
                        Positioned.fill(
                          child: CustomPaint(
                            painter: SquarePaint(),
                            size: Size(double.infinity, 200),
                          ),
                        ),
                        Row(
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
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final text in internshipTexts)
                            buildTextCard(text),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      width: double.infinity,
                      height: 300,
                      child: SuccessStoriesWidget(),
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FaqsScreen(),
                            ),
                          );
                        },
                        child: const Text('Faqs'),
                      ),
                    ),
                    SizedBox(height: 16),
                    ContactScreen(),
                    Footer(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
