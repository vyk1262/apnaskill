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
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

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

  final Map<String, IconData> iconMapping = {
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
    });
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
                                Expanded(flex: 1, child: TextSectionThree()),
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
                          icon: iconMapping[data['icon']] ?? Icons.help,
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(flex: 1, child: ImageSectionTwo()),
                        Expanded(flex: 1, child: TextSectionTwo()),
                      ],
                    ),
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
                          icon: iconMapping[data['icon']] ?? Icons.help,
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
