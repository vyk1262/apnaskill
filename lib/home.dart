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
import 'widgets/home_page_widgets/feature_modern_column.dart';
import 'widgets/home_page_widgets/feature_section_row.dart';
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
  List<Map<String, dynamic>> techContent = [];
  List<Map<String, dynamic>> techContentRow = [];

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
      techContent = List<Map<String, dynamic>>.from(data['techContent']);
      techContentRow = List<Map<String, dynamic>>.from(data['techContentRow']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      (content) => FeatureSectionRow(
                        imageUrl: content["image"]!,
                        title: content["title"]!,
                        description: content["description"]!,
                        type: techContent.indexOf(content) % 2 == 0
                            ? "Image"
                            : "Text",
                      ),
                    ),
                    SizedBox(height: 20),
                    FeatureGrid(),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: techContentRow
                          .map(
                            (content) => SizedBox(
                              width: 450,
                              child: FeatureModernColumn(
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
                    // SizedBox(height: 40),
                    // WhyChooseUs(),
                    const SizedBox(height: 40),
                    const ContactCard(),
                    SizedBox(height: 40),
                    // ContactForm(),
                    Container(
                      padding: const EdgeInsets.all(40),
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
                            bgColor: Colors.black,
                            fgColor: Colors.white,
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
