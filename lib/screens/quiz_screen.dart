import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../constants/colors.dart';

class QuizScreen extends StatefulWidget {
  final String internshipName;
  final List<String> quizList;

  const QuizScreen({
    Key? key,
    required this.internshipName,
    required this.quizList,
  }) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<String?> _userAnswers = [];
  List<Map<String, dynamic>> quizData = [];
  List<String> projectdetailsData = [];
  List<Map<String, dynamic>> assignmentData = [];
  bool showGeneralInfo = true;

  String? selectedQuiz; // Default selected quiz topic
  String? selectedAssignment; // Track selected assignment
  List<String> completedQuizzes = [];
  List<String> completedProjects = [];

  @override
  void initState() {
    super.initState();
    showGeneralInfo = true;
    _loadCompletedItems();
  }

  // Load quiz data from the selected topic JSON file
  Future<void> _loadQuizData(String topic) async {
    final String jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/${widget.internshipName}/quizzes/$topic.json');
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);
    setState(() {
      quizData =
          List<Map<String, dynamic>>.from(jsonData['result'][0]['questions']);
      _userAnswers =
          List<String?>.filled(quizData.length, null, growable: false);
      selectedAssignment = null; // Reset assignment when quiz is loaded
    });
  }

// Load questions for the selected assignment
  void _loadProjectDetails(String assignment) {
    final details = assignmentData.firstWhere(
      (data) => data['topic'] == assignment,
      orElse: () => {'questions': []},
    );

    setState(() {
      projectdetailsData = List<String>.from(details['questions']);
      quizData.clear(); // Clear quiz data when loading assignment
    });
  }

  Future<void> _loadCompletedItems() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentReference internshipRef =
          FirebaseFirestore.instance.collection('internships').doc(user.uid);

      DocumentSnapshot snapshot = await internshipRef.get();
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

      // Set completed quizzes and projects based on Firestore data
      completedQuizzes = (data?['quizMarks'] as List<dynamic>?)
              ?.map((quiz) => quiz['quizName'] as String)
              .toList() ??
          [];
      completedProjects = (data?['projectDetailsList'] as List<dynamic>?)
              ?.map((project) => project.keys.first as String)
              .toList() ??
          [];
      setState(() {});
    }
  }

  void _submitQuiz() async {
    int correctAnswers = 0;
    for (int i = 0; i < _userAnswers.length; i++) {
      if (_userAnswers[i] == quizData[i]['correct_answer']) {
        correctAnswers++;
      }
    }

    // Prepare data for Firestore
    String userEmail = FirebaseAuth.instance.currentUser?.email ?? '';
    String quizName = selectedQuiz ?? 'Unknown';

    // Create a quiz mark entry
    Map<String, dynamic> quizEntry = {
      'quizName': quizName,
      'marks': correctAnswers,
    };

    // Get reference to Firestore
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentReference internshipRef = FirebaseFirestore.instance
          .collection('internships')
          .doc(user.uid); // Using user UID as document ID

      // First, fetch existing data to check if the quiz already exists
      DocumentSnapshot snapshot = await internshipRef.get();
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
      List<dynamic> existingQuizMarks = data?['quizMarks'] ?? [];
      // Check if this quiz already exists in the list
      bool quizExists =
          existingQuizMarks.any((entry) => entry['quizName'] == quizName);

      if (quizExists) {
        // If quiz exists, compare marks and update if the new marks are higher
        for (var entry in existingQuizMarks) {
          if (entry['quizName'] == quizName &&
              entry['marks'] < correctAnswers) {
            entry['marks'] =
                correctAnswers; // Update marks if new marks are higher
          }
        }
        await internshipRef.set({
          'email': userEmail,
          'quizMarks': existingQuizMarks,
        }, SetOptions(merge: true));
      } else {
        // If quiz doesn't exist, add it to the array
        await internshipRef.set({
          'email': userEmail,
          'quizMarks': FieldValue.arrayUnion([quizEntry]),
        }, SetOptions(merge: true));
      }
    }

    // Show results dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quiz Results'),
          content: Text(
            'Total Questions: ${quizData.length}\n'
            'Attempted Questions: ${_userAnswers.where((answer) => answer != null).length}\n'
            'Correct Answers: $correctAnswers\n\n'
            'TOTAL MARKS: $correctAnswers',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  showGeneralInfo = true;
                  selectedQuiz = '';
                });
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    completedQuizzes.add(quizName);
    setState(() {});
  }

  void _submitProjectDetails(String url) async {
    String userEmail = FirebaseAuth.instance.currentUser?.email ?? '';

    // Create a project details entry
    String projectName = selectedAssignment ?? 'Unknown Project';
    Map<String, dynamic> projectEntry = {
      projectName: url,
    };

    // Get reference to Firestore
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentReference internshipRef = FirebaseFirestore.instance
          .collection('internships')
          .doc(user.uid); // Using user UID as document ID

      // First, fetch existing data to check if the project already exists
      DocumentSnapshot snapshot = await internshipRef.get();
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
      List<dynamic> existingProjects = data?['projectDetailsList'] ?? [];

      // Check if this project already exists in the list
      bool projectExists =
          existingProjects.any((entry) => entry.keys.first == projectName);

      if (projectExists) {
        // If project exists, update the URL
        for (var entry in existingProjects) {
          if (entry.keys.first == projectName) {
            entry[projectName] = url; // Update URL
          }
        }
        await internshipRef.set({
          'email': userEmail,
          'projectDetailsList': existingProjects,
        }, SetOptions(merge: true));
      } else {
        // If project doesn't exist, add it to the array
        await internshipRef.set({
          'email': userEmail,
          'projectDetailsList': FieldValue.arrayUnion([projectEntry]),
        }, SetOptions(merge: true));
      }
    }
    completedProjects.add(projectName);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left side menu for quiz topics and assignments
          Expanded(
            flex: 1,
            child: buildSideBar(),
          ),
          // Right side for quiz questions or assignment questions
          Expanded(
            flex: 3,
            child: showGeneralInfo
                ? buildGeneralInfoContent()
                : quizData.isEmpty && projectdetailsData.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : buildContent(),
          ),
        ],
      ),
    );
  }

  Widget buildSideBar() {
    return Container(
      color: Colors.black,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ElevatedButton.icon(
            icon: Icon(
              Icons.arrow_back,
              size: 24,
            ),
            label: Text(
              "Go Back",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(height: 10),
          Text(
            widget.internshipName.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const Divider(),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: Icon(
                Icons.info,
              ),
              title: const Text("GENERAL INFO"),
              selected: showGeneralInfo,
              onTap: () {
                setState(() {
                  showGeneralInfo = true;
                  selectedQuiz = '';
                  selectedAssignment = null;
                  quizData.clear();
                  projectdetailsData.clear();
                });
              },
            ),
          ),
          const Divider(),
          Text(
            "Quizzes",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ...widget.quizList.map((topic) {
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: ListTile(
                leading: Icon(Icons.quiz),
                title: Text(
                  topic.replaceAll('-', ' ').toUpperCase(),
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                trailing: completedQuizzes.contains(topic)
                    ? Icon(Icons.done, color: Colors.green)
                    : null,
                selected: selectedQuiz == topic,
                onTap: () {
                  setState(() {
                    selectedQuiz = topic;
                    selectedAssignment = null;
                    projectdetailsData.clear();
                    showGeneralInfo = false;
                    _loadQuizData(topic);
                  });
                },
              ),
            );
          }).toList(),
          const Divider(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget buildContent() {
    if (showGeneralInfo) {
      return buildGeneralInfoContent();
    } else if (quizData.isNotEmpty) {
      return buildQuizContent();
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  Widget buildQuizContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: quizData.length,
            itemBuilder: (context, index) {
              final question = quizData[index];
              return Card(
                elevation: 4, // Subtle shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
                margin: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 16), // Card margin
                child: Padding(
                  padding:
                      const EdgeInsets.all(16.0), // Padding inside the card
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Question Text with enhanced styling
                      Text(
                        question['question'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Display options for the question
                      ...question['options'].entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 2.0),
                          child: RadioListTile<String>(
                            title: Text(
                              entry.value,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white54,
                              ),
                            ),
                            value: entry.key,
                            groupValue: _userAnswers[index],
                            onChanged: (value) {
                              setState(() {
                                _userAnswers[index] = value;
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: _submitQuiz,
          child: const Text('Submit'),
        ),
      ],
    );
  }

  Widget buildGeneralInfoContent() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("General Information"),
          ],
        ),
      ),
    );
  }
}
