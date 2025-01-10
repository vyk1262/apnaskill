import 'package:apnaskill/constants/colors.dart';
import 'package:apnaskill/screens/faqs.dart';
import 'package:apnaskill/widgets/home_page_widgets/contact.dart';
import 'package:apnaskill/widgets/home_page_widgets/feature_widget.dart';
import 'package:apnaskill/widgets/footer.dart';
import 'package:apnaskill/widgets/home_page_widgets/google_form_button.dart';
import 'package:apnaskill/widgets/home_page_widgets/image_section.dart';
import 'package:apnaskill/widgets/home_page_widgets/text_section_one.dart';
import 'package:apnaskill/widgets/paint_widgets/square_grid_paint.dart';
import 'package:apnaskill/widgets/home_page_widgets/text_card_widget.dart';
import 'package:apnaskill/widgets/home_page_widgets/success_stories_widget.dart';
import 'package:flutter/material.dart';

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
  final List<Map<String, dynamic>> featureData = [
    {
      'icon': Icons.person,
      'title': "Personalized Learning Programs",
      'description':
          "Tailored educational experiences designed to meet individual student needs and learning styles.",
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': "Expert-Led Workshops",
      'description':
          "Interactive sessions with industry experts aimed at skill enhancement and real-world application.",
    },
    {
      'icon': Icons.menu_book,
      'title': "Comprehensive Course Materials",
      'description':
          "Well-structured resources providing in-depth knowledge across various subjects and disciplines.",
    },
  ];

  final List<Map<String, dynamic>> contactData = [
    {'icon': Icons.email, 'title': 'Email', 'text': 'apnaskill.in@gmail.com'},
    {'icon': Icons.phone, 'title': 'Phone', 'text': '+91 8175989767'},
    {
      'icon': Icons.message_rounded,
      'title': 'Whatsapp',
      'text': '+91 8175989767'
    },
    {
      'icon': Icons.location_on,
      'title': 'Location',
      'text': 'Apnaskill, Near to Archid Tower, Baner, Pune-422045'
    },
  ];

  @override
  void initState() {
    super.initState();
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
                    Container(
                      decoration: BoxDecoration(
                        gradient: AppColors.gradientPrimary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(flex: 1, child: TextSectionFour()),
                                Expanded(flex: 2, child: TextSectionThree()),
                                Expanded(flex: 1, child: ImageSectionThree()),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: featureData.map((data) {
                        return FeatureItem(
                          icon: data['icon'],
                          title: data['title'],
                          description: data['description'],
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                          gradient: AppColors.gradientPrimary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(flex: 1, child: TextSectionOne()),
                            Expanded(flex: 1, child: ImageSectionOne()),
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
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(flex: 1, child: TextSectionTwo()),
                            Expanded(flex: 1, child: ImageSectionTwo()),
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
                    Center(
                      child: GoogleFormButton(),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: contactData.map((data) {
                        return ContactCard(
                          icon: data['icon'],
                          title: data['title'],
                          text: data['text'],
                        );
                      }).toList(),
                    ),
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
