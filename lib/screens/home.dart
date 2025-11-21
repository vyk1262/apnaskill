import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skill_factorial/screens/home_page_widgets/main_hero.dart';
import 'package:skill_factorial/screens/home_page_widgets/why.dart';

import 'common_widgets/custom_app_bar.dart';
import 'common_widgets/footer.dart';
import 'home_page_widgets/contact.dart';
import 'home_page_widgets/feature_modern_column.dart';
import 'home_page_widgets/feature_section_row.dart';
import 'home_page_widgets/feature_widget.dart';
import 'home_page_widgets/footer_cta.dart';
import 'bootcamp_courses.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
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
                    const MainHero(),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                    CoursesSection(),
                    const SizedBox(height: 20),
                    FeatureSectionRow.buildFeatureList(),
                    const SizedBox(height: 20),
                    FeatureGrid(),
                    const SizedBox(height: 20),
                    WhyChooseUs(
                      title: "Why Choose Us?",
                      description:
                          "Skill Factorial is among top-rated ed-tech companies providing Online Workshops with Certificates to working professionals.",
                      benefits: [
                        Benefit(
                            icon: FontAwesomeIcons.users,
                            text: "Enroll For Free"),
                        Benefit(
                            icon: FontAwesomeIcons.graduationCap,
                            text: "Achieve Goals"),
                        Benefit(
                            icon: FontAwesomeIcons.certificate,
                            text: "Explanations Available"),
                        Benefit(
                            icon: FontAwesomeIcons.laptop,
                            text: "Attempt Quizzes Online"),
                        Benefit(
                            icon: FontAwesomeIcons.handshake,
                            text: "Support Available"),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                    FeatureModernColumn.buildFeatureGrid(),
                    const SizedBox(height: 20),
                    const ContactCard(),
                    const SizedBox(height: 20),
                    ContactInfoSection(),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                    const FooterCTA(),
                    const SizedBox(height: 20),
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
