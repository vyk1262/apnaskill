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
import 'package:skill_factorial/widgets/home_page_widgets/main_hero.dart';
import 'package:skill_factorial/widgets/home_page_widgets/why.dart';

import 'custom_app_bar.dart';
import 'widgets/footer.dart';
import 'widgets/home_page_widgets/contact.dart';
import 'widgets/home_page_widgets/feature_modern_column.dart';
import 'widgets/home_page_widgets/feature_section_row.dart';
import 'widgets/home_page_widgets/feature_widget.dart';
import 'widgets/home_page_widgets/footer_cta.dart';

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
                    const HeroWidget(),
                    const SizedBox(height: 20),
                    FeatureSectionRow.buildFeatureList(),
                    const SizedBox(height: 20),
                    FeatureGrid(),
                    const SizedBox(height: 20),
                    FeatureModernColumn.buildFeatureGrid(),
                    const SizedBox(height: 20),
                    WhyChooseUs(),
                    const SizedBox(height: 20),
                    const ContactCard(),
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
