import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_factorial/constants/colors.dart';
import 'package:skill_factorial/screens/register.dart';
import 'package:skill_factorial/widgets/grid_dot_paint.dart';
import 'package:skill_factorial/widgets/home_page_widgets/cta_button.dart';
import 'package:skill_factorial/widgets/home_page_widgets/hero.dart';
import 'package:skill_factorial/widgets/home_page_widgets/why.dart';

import 'custom_app_bar.dart';
import 'widgets/footer.dart';
import 'widgets/home_page_widgets/contact.dart';
import 'widgets/home_page_widgets/feature_section.dart';
import 'widgets/home_page_widgets/feature_widget.dart';
import 'widgets/home_page_widgets/text_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> syllabus = [];
  bool isLoading = true;
  List<String> internshipTexts = [];
  List<Map<String, dynamic>> featureData = [];
  List<Map<String, dynamic>> contactData = [];
  List<Map<String, dynamic>> techContent = [];
  List<Map<String, dynamic>> techContentRow = [];

  final Map<String, IconData> iconMapping = {
    "clock": FontAwesomeIcons.clock,
    "book": FontAwesomeIcons.book,
    "chartLine": FontAwesomeIcons.chartLine,
    "doubts": FontAwesomeIcons.question,
    "person": Icons.person,
    "lightbulb_outline": Icons.lightbulb_outline,
    "menu_book": Icons.menu_book,
    "email": Icons.email,
    "phone": Icons.phone,
    "whatsapp_rounded": Icons.message_rounded,
    "location_on": Icons.location_on,
  };

  @override
  void initState() {
    super.initState();
    loadAppTextJsonData();
  }

  Future<void> loadAppTextJsonData() async {
    final String response =
        await rootBundle.loadString('assets/app-data-text.json');
    final data = json.decode(response);

    setState(() {
      internshipTexts = List<String>.from(data['internshipTexts']);
      featureData = List<Map<String, dynamic>>.from(data['featureData']);
      contactData = List<Map<String, dynamic>>.from(data['contactData']);
      techContent = List<Map<String, dynamic>>.from(data['techContent']);
      techContentRow = List<Map<String, dynamic>>.from(data['techContentRow']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: CustomAppBar(),
      body: Row(
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  children: [
                    HeroWidget(),
                    SizedBox(height: 20),
                    ...techContent.map(
                      (content) => FeatureSectionNew(
                        imageUrl: content["image"]!,
                        title: content["title"]!,
                        description: content["description"]!,
                        type: techContent.indexOf(content) % 2 == 0
                            ? "Image"
                            : "Text",
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.primaryColor,
                            AppColors.secondaryColor,
                          ],
                        ),
                      ),
                      child: Wrap(
                        spacing: 50,
                        runSpacing: 20,
                        alignment: WrapAlignment.center,
                        children: featureData.map((data) {
                          return SizedBox(
                            width: 250,
                            child: FeatureItem(
                              icon: iconMapping[data['icon']] ?? Icons.help,
                              title: data['title'],
                              description: data['description'],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: techContentRow
                          .map(
                            (content) => SizedBox(
                              width: 450,
                              child: FeatureModern(
                                imageUrl: content["image"]!,
                                title: content["title"]!,
                                description: content["description"]!,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(height: 20),
                    // Padding(
                    //   padding: const EdgeInsets.all(16.0),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       for (final text in internshipTexts)
                    //         AnimatedSwitcher(
                    //           duration: const Duration(milliseconds: 500),
                    //           child: buildTextCard(text),
                    //         ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(height: 40),
                    WhyChooseUs(),
                    const SizedBox(height: 40),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.primaryColor,
                            AppColors.secondaryColor,
                          ],
                        ),
                      ),
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        alignment: WrapAlignment.center,
                        children: contactData.map((data) {
                          return SizedBox(
                            width: 250,
                            child: ContactCard(
                              icon: iconMapping[data['icon']] ?? Icons.help,
                              title: data['title'],
                              text: data['text'],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 40),
                    // ContactForm(),
                    Container(
                      padding: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.primaryColor,
                            AppColors.secondaryColor,
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Ready to Test Your Knowledge?',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          buildCtaButton(
                            text: "Begin Your Quiz Journey",
                            onPressed: () => context.go('/login'),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),
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
