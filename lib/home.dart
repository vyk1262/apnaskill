import 'package:apnaskill/screens/faqs.dart';
import 'package:apnaskill/widgets/contact.dart';
import 'package:apnaskill/widgets/do_text.dart';
import 'package:apnaskill/widgets/footer.dart';
import 'package:apnaskill/widgets/main_text.dart';
import 'package:apnaskill/widgets/text_we.dart';
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
                    DoTextInfo(),
                    const SizedBox(height: 40),
                    CenteredTextWidget(),
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
