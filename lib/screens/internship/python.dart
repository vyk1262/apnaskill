import 'dart:convert';
import 'package:apnaskill/screens/internships.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class QuizScreen extends StatefulWidget {
  final String internshipName;
  final List<String> quizList;
  final List<String> projectList;

  const QuizScreen(
      {Key? key,
      required this.internshipName,
      required this.quizList,
      required this.projectList})
      : super(key: key);

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
    _loadProjectData();
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

  // Load assignment data from JSON files
  Future<void> _loadProjectData() async {
    for (String assignment in widget.projectList) {
      final String jsonString = await DefaultAssetBundle.of(context).loadString(
          'assets/${widget.internshipName}/projects/$assignment.json');
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);
      assignmentData
          .addAll(List<Map<String, dynamic>>.from(jsonData['result']));
    }
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
      color: Colors.blueGrey[50],
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
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[100], // Background color
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.internshipName.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.info, color: Colors.blueGrey[700]),
            title: const Text(
              "GENERAL INFO",
            ),
            selected: showGeneralInfo,
            tileColor: showGeneralInfo ? Colors.blue[100] : null,
            onTap: () {
              setState(() {
                showGeneralInfo = true;
                selectedQuiz = ''; // Deselect quiz
                selectedAssignment = null; // Deselect assignment
                quizData.clear();
                projectdetailsData.clear();
              });
            },
          ),

          // Quiz Topics
          Text(
            "Quizzes",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey[800],
            ),
          ),
          const SizedBox(height: 10),
          ...widget.quizList.map((topic) {
            return ListTile(
              leading: Icon(
                Icons.quiz,
              ),
              title: Text(
                topic.replaceAll('-', ' ').toUpperCase(),
                style: TextStyle(
                  fontSize: 18,
                  color: selectedQuiz == topic ? Colors.blue : Colors.black,
                ),
              ),
              trailing: completedQuizzes.contains(topic)
                  ? Icon(Icons.done, color: Colors.green)
                  : null,
              selected: selectedQuiz == topic,
              tileColor: selectedQuiz == topic
                  ? Colors.blue[100]
                  : null, // Highlight selected item
              onTap: () {
                setState(() {
                  selectedQuiz = topic;
                  projectdetailsData.clear();
                  showGeneralInfo = false;
                  _loadQuizData(topic);
                });
              },
            );
          }).toList(),
          const Divider(), // Divider for better visual separation
          const SizedBox(height: 10), // Space before assignments
          Text(
            "Projects",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey[800],
            ),
          ),
          const SizedBox(height: 10),
          ...widget.projectList.map((assignment) {
            return ListTile(
              leading: Icon(Icons.assignment,
                  color: Colors.blueGrey[700]), // Icon for assignments
              title: Text(
                assignment.replaceAll('_', ' ').toUpperCase(),
                style: TextStyle(
                  fontSize: 18,
                  color: selectedAssignment == assignment
                      ? Colors.blue
                      : Colors.black,
                ),
              ),
              trailing: completedProjects.contains(assignment)
                  ? Icon(Icons.done, color: Colors.green)
                  : null,
              selected: selectedAssignment == assignment,
              tileColor: selectedAssignment == assignment
                  ? Colors.blue[100]
                  : null, // Highlight selected ite
              onTap: () {
                setState(() {
                  selectedAssignment = assignment;
                  quizData.clear();
                  showGeneralInfo = false;
                  _loadProjectDetails(assignment);
                });
              },
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget buildContent() {
    if (showGeneralInfo) {
      return buildGeneralInfoContent();
    } else if (projectdetailsData.isNotEmpty) {
      return buildAssignmentContent();
    } else if (quizData.isNotEmpty) {
      return buildQuizContent();
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  Widget buildQuizContent() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: quizData.length,
            itemBuilder: (context, index) {
              final question = quizData[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(question['question']),
                      ...question['options'].entries.map((entry) {
                        return RadioListTile<String>(
                          title: Text(entry.value),
                          value: entry.key,
                          groupValue: _userAnswers[index],
                          onChanged: (value) {
                            setState(() {
                              _userAnswers[index] = value;
                            });
                          },
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

  Widget buildAssignmentContent() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: projectdetailsData.length,
            itemBuilder: (context, index) {
              final question = projectdetailsData[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(question),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(labelText: 'Project URL'),
          onSubmitted: (url) {
            _submitProjectDetails(url); // Call to submit project details
          },
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
