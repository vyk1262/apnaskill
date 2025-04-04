import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_factorial/home.dart';

import '../custom_app_bar.dart';
import 'syllabus_view.dart';
import 'quiz_screen.dart';

class QuizListHome extends StatefulWidget {
  const QuizListHome({Key? key}) : super(key: key);

  @override
  State<QuizListHome> createState() => _QuizListHomeState();
}

class _QuizListHomeState extends State<QuizListHome> {
  Map<String, dynamic>? userData;
  User? user = FirebaseAuth.instance.currentUser;
  List<String> pythonQuizTopics = [
    'files',
    'functions',
    'oops',
    'error_handling',
    'data_structures',
    'advanced',
    'applications',
    'control_flow',
    'intro',
    'modules'
  ];

  List<String> webQuizTopics = [
    "html_intro",
    "html_forms",
    "html_media",
    "html_apis",
    "css_intro",
    "css_responsive",
    "css_advanced",
    "js_intro",
    "js_bom",
    "js_async",
    "js_apis",
  ];

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        userData = snapshot.data() as Map<String, dynamic>?;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildInternshipTile(
                context, "Python Programming", pythonQuizTopics),
            buildInternshipTile(context, "Web Development", webQuizTopics),
            buildInternshipTile(context, "Data Science", pythonQuizTopics),
            buildInternshipTile(context, "Machine Learning", pythonQuizTopics),
            buildInternshipTile(
                context, "Mobile App Development", pythonQuizTopics),
          ],
        ),
      ),
    );
  }

  Widget buildInternshipTile(
      BuildContext context, String internshipName, List<String> quizList) {
    bool isUnlocked = userData?['internshipsList']?.any(
            (internship) => internship['internshipName'] == internshipName) ??
        false;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (MediaQuery.of(context).size.width > 700)
                  Image.asset(
                    'assets/ai.jpg',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                const SizedBox(width: 10),
                Container(
                  width: MediaQuery.of(context).size.width < 700
                      ? MediaQuery.of(context).size.width / 1.4
                      : MediaQuery.of(context).size.width / 2,
                  color: Colors.black,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      if (MediaQuery.of(context).size.width < 700)
                        Image.asset(
                          'assets/ai.jpg',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      const SizedBox(height: 5),
                      Icon(
                        isUnlocked ? Icons.check_circle : Icons.lock,
                        color: isUnlocked ? Colors.green : Colors.red,
                        size: 40,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        internshipName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        isUnlocked
                            ? "Unlocked - Start Learning with Practice"
                            : "Locked - Tap to Unlock",
                        style: TextStyle(
                            color: isUnlocked ? Colors.green : Colors.red),
                      ),
                      const SizedBox(height: 5),
                      ElevatedButton(
                        onPressed: () {
                          if (user == null) {
                            GoRouter.of(context).go('/login');
                            return;
                          }
                          if (isUnlocked) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuizScreen(
                                  internshipName: internshipName,
                                  quizList: quizList,
                                ),
                              ),
                            );
                          } else {
                            _showUnlockDialog(context, internshipName);
                          }
                        },
                        child: Text(isUnlocked ? "Start Quiz" : "Unlock"),
                      ),
                      const SizedBox(height: 5),
                      ElevatedButton(
                        onPressed: () {
                          _loadSyllabus(context, internshipName);
                        },
                        child: const Text("Syllabus"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showUnlockDialog(BuildContext context, String internshipName) {
    final upiController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Unlock $internshipName"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Scan the QR code below to pay',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Image.asset(
              'assets/ai.jpg',
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
            Text("Enter UPI Transaction ID"),
            TextField(controller: upiController),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (upiController.text.isNotEmpty) {
                await _unlockInternship(internshipName, upiController.text);
                Navigator.of(context).pop();
              }
            },
            child: Text("Submit"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  Future<void> _unlockInternship(String internshipName, String upiTraId) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'internshipsList': FieldValue.arrayUnion([
          {'internshipName': internshipName, 'upiTraId': upiTraId}
        ])
      });
      _fetchUserData(); // Refresh user data to reflect the new unlocked internship
    }
  }

  Future<void> _loadSyllabus(
      BuildContext context, String internshipName) async {
    try {
      String jsonString = await rootBundle.loadString('assets/api-data.json');
      final jsonDataAll = jsonDecode(jsonString);

      if (jsonDataAll['status'] == 'success' && jsonDataAll['result'] is List) {
        List<dynamic> results = jsonDataAll['result'];

        List<dynamic>?
            syllabusData; // Declare syllabusData outside the loop, nullable

        for (var subjectData in results) {
          if (subjectData is Map &&
              subjectData.containsKey('subject') &&
              subjectData['subject'] == internshipName &&
              subjectData.containsKey('syllabus') &&
              subjectData['syllabus'] is List) {
            syllabusData = subjectData['syllabus']; // Assign the syllabus here
            break; // Exit the loop once the subject is found
          }
        }

        if (syllabusData != null) {
          // Check if syllabusData was found
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SyllabusScreen(
                internshipName: internshipName,
                syllabusData: syllabusData, // Pass the syllabusData
              ),
            ),
          );
        } else {
          // Handle the case where the subject is not found
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Syllabus not found for $internshipName.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid JSON format.')),
        );
      }
    } catch (e) {
      print("Error loading syllabus: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading syllabus. Please try again.')),
      );
    }
  }
}
