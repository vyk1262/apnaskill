import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_factorial/screens/custom_search_bar.dart';

import '../custom_app_bar.dart';
import 'quiz_screen.dart';
import 'syllabus_view.dart';

class QuizListHome extends StatefulWidget {
  const QuizListHome({Key? key}) : super(key: key);

  @override
  State<QuizListHome> createState() => _QuizListHomeState();
}

class _QuizListHomeState extends State<QuizListHome> {
  Map<String, dynamic>? userData;
  User? user = FirebaseAuth.instance.currentUser;
  Map<String, List<String>> quizTopics = {};
  List<String> allInternshipNames = [
    "Python Programming",
    "Web Development",
    "Data Science",
    "Machine Learning",
  ];
  List<String> filteredInternshipNames = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    _loadQuizTopics();
    filteredInternshipNames.addAll(allInternshipNames);
    _searchController.addListener(_filterInternships);
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

  Future<void> _loadQuizTopics() async {
    try {
      for (final internship in allInternshipNames) {
        final assetPath = 'assets/course_topics/$internship.json';
        try {
          final data = await rootBundle.loadString(assetPath);
          final list = (jsonDecode(data) as List).cast<String>();
          setState(() {
            quizTopics[internship] = list;
          });
        } catch (innerError) {
          print('Error loading asset for $internship: $innerError');
        }
      }
    } catch (e) {
      print('Error during quiz topics loading: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Error loading quiz topics. Please try again.')),
      );
    }
  }

  void _filterInternships() {
    setState(() {
      filteredInternshipNames = allInternshipNames
          .where((internship) => internship
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomSearchBar(
                  controller: _searchController, hintText: 'Search topics...'),
              const SizedBox(height: 16),
              Expanded(
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    int crossAxisCount = 1;
                    if (constraints.maxWidth >= 600) {
                      crossAxisCount = 2;
                    }
                    if (constraints.maxWidth >= 900) {
                      crossAxisCount = 3;
                    }
                    if (constraints.maxWidth >= 1200) {
                      crossAxisCount = 4;
                    }

                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: 1.0,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: filteredInternshipNames.length,
                      itemBuilder: (context, index) {
                        final internshipName = filteredInternshipNames[index];
                        final quizList = quizTopics[internshipName] ?? [];
                        return buildInternshipCard(
                            context, internshipName, quizList);
                      },
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }

  Widget buildInternshipCard(
      BuildContext context, String internshipName, List<String> quizList) {
    bool isUnlocked = userData?['internshipsList']?.any(
            (internship) => internship['internshipName'] == internshipName) ??
        false;

    String imagePath = 'assets/course_images/$internshipName.jpeg';

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: InkWell(
        onTap: () {
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              Icon(
                isUnlocked ? Icons.check_circle : Icons.lock,
                color: isUnlocked ? Colors.green : Colors.red,
                size: 30,
              ),
              const SizedBox(height: 5),
              Text(
                internshipName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),
              Text(
                isUnlocked ? "Unlocked" : "Locked",
                style: TextStyle(color: isUnlocked ? Colors.green : Colors.red),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _loadSyllabus(context, internshipName);
                    },
                    child: const Text("Syllabus"),
                  ),
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isUnlocked ? Colors.green : Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                  ),
                ],
              ),
            ],
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
              'assets/student_home/qrcode.jpg',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            const Text("Enter UPI Transaction ID"),
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
            child: const Text("Submit"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
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
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Syllabus not found for $internshipName.')));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid JSON format.')));
      }
    } catch (e) {
      print("Error loading syllabus: $e");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Error loading syllabus. Please try again.')));
    }
  }
}
