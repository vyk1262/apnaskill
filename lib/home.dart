import 'package:apnaskill/paints/stars.dart';
import 'package:apnaskill/screens/contact.dart';
import 'package:apnaskill/widgets/do_text.dart';
import 'package:apnaskill/widgets/footer.dart';
import 'package:apnaskill/paints/square.dart';
import 'package:apnaskill/widgets/main_text.dart';
import 'package:apnaskill/widgets/text_we.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                    Stack(
                      children: [
                        Positioned.fill(
                          child: CustomPaint(
                            painter: StarryNightStyle(),
                            size: Size(double.infinity,
                                200), // Adjust the size as needed
                          ),
                        ),
                        MainTextInfo(),
                      ],
                    ),
                    const SizedBox(height: 16),

                    SizedBox(height: 16),

                    Stack(
                      children: [
                        Positioned.fill(
                          child: CustomPaint(
                            painter: SquarePaint(),
                            size: Size(double.infinity, 200),
                          ),
                        ),
                        DoTextInfo(),
                      ],
                    ),
                    const SizedBox(height: 100),

                    const SizedBox(height: 16),
                    CenteredTextWidget(),
                    SizedBox(
                      height: 400,
                      child: ContactScreen(),
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
