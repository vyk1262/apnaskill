import 'package:apnaskill/paints/bubbles.dart';
import 'package:apnaskill/paints/river.dart';
import 'package:apnaskill/paints/stars.dart';
import 'package:apnaskill/screens/faqs.dart';
import 'package:apnaskill/widgets/footer.dart';
import 'package:apnaskill/paints/square.dart';
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

  var info = {
    "about":
        "ApnaSkill.in is your gateway to the exciting world of technology. We're passionate about empowering students like YOU with the skills and experience needed to thrive in the IT industry."
  };

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
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Image.asset(
                                      'assets/apna-bg.png',
                                      // width: 100,
                                      height: 400,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        Text(
                                          "Build Confidence and Land Your Dream Job with Virtual Internships",
                                          style: TextStyle(fontSize: 25),
                                        ),
                                        Text(
                                          'What do YOU get?',
                                          style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 16),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.check_circle, size: 48),
                                            SizedBox(width: 16),
                                            Text(
                                              'Internship Completion Certificate',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 16),
                                        Center(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              const url =
                                                  'https://forms.gle/gqaYp61V1B4XQPwu7';
                                              openUrl(url);
                                            },
                                            child: const Text('Register here'),
                                          ),
                                        ),
                                        SizedBox(height: 16),
                                      ],
                                    ),
                                  ),
                                  // Expanded(
                                  //   flex: 1,
                                  //   child: Image.asset(
                                  //     'assets/apna-bg.png',
                                  //     // width: 100,
                                  //     height: 400,
                                  //     fit: BoxFit.contain,
                                  //   ),
                                  // ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Column(
                                children: [
                                  Container(
                                    // color: Colors.blue,
                                    child: Text(
                                      "Breaking Through the Job Market: Overcoming the Experience Barrier",
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  ),
                                  Container(
                                    // color: Colors.blue,
                                    child: Text(
                                      "Kickstart Your Career Journey with Virtual Internships",
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  ),
                                  CustomPaint(
                                    painter: StaticRiverStyle(),
                                    size: Size(double.infinity,
                                        200), // Adjust the size as needed
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Internships/ Trainings in ',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.check_circle, size: 48),
                                  SizedBox(width: 16),
                                  Text(
                                    'Python Programming',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.check_circle, size: 48),
                                  SizedBox(width: 16),
                                  Text(
                                    'Web development',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    SizedBox(height: 16),

                    Stack(
                      children: [
                        Positioned.fill(
                          child: CustomPaint(
                            painter: SquarePaint(),
                            size: Size(double.infinity,
                                200), // Adjust the size as needed
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: const Column(
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
                                        'Complete Assignments',
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
                                        'Complete Quizzes',
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
                                        'Complete Projects',
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
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Image.asset(
                            'assets/apna-cert.png',
                            // width: double.infinity,
                            // height: 550,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.arrow_back,
                                  size: MediaQuery.of(context).size.width *
                                      0.1, // Dynamic size based on screen height
                                ),
                                Text(
                                  "Example Intership Certificate",
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context)
                                            .size
                                            .width *
                                        0.03, // Dynamic size based on screen height
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      info["about"] ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Footer()
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
