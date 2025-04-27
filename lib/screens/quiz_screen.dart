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
  List<Map<String, dynamic>> assignmentData = [];
  bool showGeneralInfo = true;

  String? selectedQuiz; // Default selected quiz topic
  String? selectedAssignment; // Track selected assignment
  List<String> completedQuizzes = [];
  bool _showSidebarMobile = false;

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
      _showSidebarMobile = false; // Hide sidebar when content loads
    });
  }

  Future<void> _loadCompletedItems() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentReference internshipRef =
          FirebaseFirestore.instance.collection('internships').doc(user.uid);

      DocumentSnapshot snapshot = await internshipRef.get();
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

      completedQuizzes = (data?['quizMarks'] as List<dynamic>?)
              ?.map((quiz) => quiz['quizName'] as String)
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

    String userEmail = FirebaseAuth.instance.currentUser?.email ?? '';
    String quizName = selectedQuiz ?? 'Unknown';

    // Create a quiz mark entry
    Map<String, dynamic> quizEntry = {
      'quizName': quizName,
      'marks': correctAnswers,
    };

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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 768; // Adjust threshold as needed

    return Scaffold(
      appBar: isMobile
          ? AppBar(
              title: Text(widget.internshipName.toUpperCase()),
              leading: IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    _showSidebarMobile = !_showSidebarMobile;
                  });
                },
              ),
            )
          : null,
      body: Row(
        children: [
          // Left side menu for quiz topics and assignments
          if (!isMobile || _showSidebarMobile)
            Expanded(
              flex: 1,
              child: buildSideBar(isMobile),
            ),
          // Right side for quiz questions or assignment questions
          if (!isMobile ||
              (!_showSidebarMobile && showGeneralInfo) ||
              (!_showSidebarMobile && quizData.isNotEmpty))
            Expanded(
              flex: 3,
              child: buildContent(),
            ),
        ],
      ),
    );
  }

  Widget buildSideBar(bool isMobile) {
    return Container(
      width: isMobile
          ? _showSidebarMobile
              ? MediaQuery.of(context)
                  .size
                  .width // Occupy full width on mobile when open
              : null
          : null,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          if (isMobile)
            ElevatedButton.icon(
              icon: const Icon(
                Icons.close,
                size: 24,
              ),
              label: const Text(
                "Close Menu",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                setState(() {
                  _showSidebarMobile = false;
                });
              },
            ),
          if (isMobile) const SizedBox(height: 10),
          ElevatedButton.icon(
            icon: const Icon(
              Icons.arrow_back,
              size: 24,
            ),
            label: const Text(
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
          const SizedBox(height: 10),
          Text(
            widget.internshipName.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const Divider(),
          Container(
            decoration: BoxDecoration(
              color: showGeneralInfo ? Colors.black : Colors.blue,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: showGeneralInfo ? Colors.red : Colors.transparent,
              ),
            ),
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              leading: const Icon(
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
                  if (isMobile) _showSidebarMobile = false;
                });
              },
            ),
          ),
          const Divider(),
          const Text(
            "Quizzes",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ...widget.quizList.map((topic) {
            return Container(
              decoration: BoxDecoration(
                  color: selectedQuiz == topic ? Colors.black : Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color:
                        selectedQuiz == topic ? Colors.red : Colors.transparent,
                  )),
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: ListTile(
                leading: const Icon(Icons.quiz),
                title: Text(
                  topic.replaceAll('-', ' ').toUpperCase(),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                trailing: completedQuizzes.contains(topic)
                    ? const Icon(Icons.done, color: Colors.white)
                    : null,
                selected: selectedQuiz == topic,
                onTap: () {
                  setState(() {
                    selectedQuiz = topic;
                    selectedAssignment = null;
                    showGeneralInfo = false;
                    _loadQuizData(topic);
                    if (isMobile) _showSidebarMobile = false;
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
                    vertical: 5, horizontal: 8), // Card margin
                child: Padding(
                  padding:
                      const EdgeInsets.all(16.0), // Padding inside the card
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Question Text with enhanced styling
                      Text(
                        question['question'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Display options for the question
                      ...question['options'].entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 1.0),
                          child: RadioListTile<String>(
                            activeColor: Colors.black,
                            contentPadding: const EdgeInsets.all(0),
                            tileColor: Colors.black54,
                            title: Text(
                              entry.value,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
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
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _submitQuiz,
            child: const Text('Submit'),
          ),
        ),
      ],
    );
  }

  Widget buildGeneralInfoContent() {
    return const Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to the Quizzes!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                "Here's how to take the quizzes and check your scores:",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              Text(
                "1. **Select a Quiz Topic:** On the left side, you'll see a list of available quiz topics. Tap on the topic you want to attempt.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                "2. **Answer the Questions:** Once a topic is selected, the quiz questions will appear on the right side. Carefully read each question and select the best answer from the given options.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                "3. **Submit Your Answers:** After you have answered all the questions in the quiz, click the 'Submit' button at the bottom.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 15),
              Text(
                "**Checking Your Scores:**",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "You can view your quiz results on the **Profile Screen**.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                "**Desktop Mode:** Look for a **Profile Icon** (usually a person icon) in the app bar at the top of the screen and click on it.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                "**Mobile View:** Tap on the **Hamburger Icon** (three horizontal lines) typically located in the top left or right corner of the app bar. This will open a menu where you can find the 'Profile' option.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 15),
              Text(
                "On the Profile Screen, you will find a section dedicated to your quiz scores, showing the marks you obtained in each quiz you have completed.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
