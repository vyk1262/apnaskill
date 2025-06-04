import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../constants/colors.dart';
import 'ViewResponses.dart';

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
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      Map<String, dynamic>? userData = snapshot.data() as Map<String, dynamic>?;

      if (userData != null && userData.containsKey('internshipsList')) {
        List<dynamic> internshipsList = userData['internshipsList'];

        // Find the specific internship entry
        var currentInternship = internshipsList.firstWhere(
          (internship) => internship['internshipName'] == widget.internshipName,
          orElse: () => null, // Return null if not found
        );

        if (currentInternship != null &&
            currentInternship.containsKey('quizMarks')) {
          completedQuizzes = (currentInternship['quizMarks'] as List<dynamic>?)
                  ?.map((quiz) => quiz['quizName'] as String)
                  .toList() ??
              [];
        } else {
          completedQuizzes = [];
        }
      } else {
        completedQuizzes = [];
      }
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

    String quizName = selectedQuiz ?? 'Unknown';

    // Create a quiz mark entry
    Map<String, dynamic> quizEntry = {
      'quizName': quizName,
      'marks': correctAnswers,
    };

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);

      // 1. Fetch the user's document
      DocumentSnapshot userSnapshot = await userDocRef.get();
      Map<String, dynamic>? userData =
          userSnapshot.data() as Map<String, dynamic>?;

      if (userData != null && userData.containsKey('internshipsList')) {
        List<dynamic> internshipsList =
            List.from(userData['internshipsList']); // Create a mutable copy

        // 2. Find the index of the specific internship
        int internshipIndex = internshipsList.indexWhere(
          (internship) => internship['internshipName'] == widget.internshipName,
        );

        if (internshipIndex != -1) {
          // 3. Get the specific internship map
          Map<String, dynamic> currentInternship =
              Map<String, dynamic>.from(internshipsList[internshipIndex]);

          // Ensure 'quizMarks' exists in the internship map, initialize if not
          if (!currentInternship.containsKey('quizMarks')) {
            currentInternship['quizMarks'] = [];
          }

          List<dynamic> existingQuizMarks =
              List.from(currentInternship['quizMarks']);

          // 4. Check if this quiz already exists in the quizMarks list for this internship
          int quizMarkIndex = existingQuizMarks.indexWhere(
            (entry) => entry['quizName'] == quizName,
          );

          if (quizMarkIndex != -1) {
            // If quiz exists, compare marks and update if the new marks are higher
            if (existingQuizMarks[quizMarkIndex]['marks'] < correctAnswers) {
              existingQuizMarks[quizMarkIndex]['marks'] = correctAnswers;
            }
          } else {
            // If quiz doesn't exist, add it to the array
            existingQuizMarks.add(quizEntry);
          }
          // 5. Update the 'quizMarks' for the current internship
          currentInternship['quizMarks'] = existingQuizMarks;
          // 6. Update the internship entry in the internshipsList
          internshipsList[internshipIndex] = currentInternship;
          // 7. Update the entire 'internshipsList' in the user's document
          await userDocRef.update({
            'internshipsList': internshipsList,
          });
        } else {
          // This case should ideally not happen if internshipName is always valid
          // You might want to log a warning or handle it based on your app's logic
          print(
              "Error: Internship '${widget.internshipName}' not found for user.");
        }
      } else {
        print("Error: 'internshipsList' not found or is null for user.");
      }
    }

    // Show results dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Quiz Results',
            textAlign: TextAlign.center, // Center the title
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          content: SingleChildScrollView(
            // Use SingleChildScrollView in case content is long
            child: Column(
              mainAxisSize: MainAxisSize.min, // Keep column compact
              children: [
                ListTile(
                  leading: Icon(Icons.playlist_add_check, color: Colors.blue),
                  title: Text('Total Questions'),
                  trailing: Text('${quizData.length}',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                ListTile(
                  leading: Icon(Icons.done_all, color: Colors.green),
                  title: Text('Attempted Questions'),
                  trailing: Text(
                    '${_userAnswers.where((answer) => answer != null).length}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.check_circle_outline, color: Colors.teal),
                  title: Text('Correct Answers'),
                  trailing: Text(
                    '$correctAnswers',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                ),
                Divider(), // A subtle divider for separation
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'TOTAL MARKS',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '$correctAnswers',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.deepPurple, // Highlight total marks
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20), // Add some space
                ElevatedButton.icon(
                  // Use ElevatedButton.icon for a nicer button
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewResponses(
                          quizData: quizData,
                          userAnswers: _userAnswers,
                          quizName: quizName,
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.remove_red_eye),
                  label: Text('View Responses'),
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        Size(double.infinity, 45), // Make button full width
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  showGeneralInfo = true;
                  selectedQuiz = '';
                });
                _loadCompletedItems();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    // The completedQuizzes list is updated by _loadCompletedItems, so no direct add here.
    // completedQuizzes.add(quizName); // This line is no longer needed here as _loadCompletedItems will refresh it
    setState(() {}); // Trigger a rebuild to reflect the UI changes
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
              ? MediaQuery.of(context).size.width
              : null
          : null,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A237E), Color(0xFF3949AB)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          if (isMobile)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.close, size: 24, color: Colors.white),
                label: const Text(
                  "Close Menu",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => setState(() => _showSidebarMobile = false),
              ),
            ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: ElevatedButton.icon(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 20,
                color: Colors.white,
              ),
              label: const Text(
                "Back to Courses",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.2),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.school,
                  size: 28,
                  color: Colors.white,
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    widget.internshipName.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: showGeneralInfo
                  ? Colors.white.withOpacity(0.15)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: showGeneralInfo
                    ? Colors.white.withOpacity(0.5)
                    : Colors.white.withOpacity(0.1),
                width: 2,
              ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              leading: Icon(
                Icons.info_outline,
                color: Colors.white.withOpacity(0.9),
                size: 26,
              ),
              title: const Text(
                "Course Overview",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
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
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                const Icon(
                  Icons.quiz_outlined,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 12),
                const Text(
                  "Available Quizzes",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          ...widget.quizList.map((topic) {
            final bool isSelected = selectedQuiz == topic;
            final bool isCompleted = completedQuizzes.contains(topic);
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.15)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? Colors.white.withOpacity(0.5)
                      : Colors.white.withOpacity(0.1),
                  width: 2,
                ),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                leading: Stack(
                  children: [
                    Icon(
                      Icons.assignment_outlined,
                      color: Colors.white.withOpacity(0.9),
                      size: 26,
                    ),
                    if (isCompleted)
                      Positioned(
                        right: -2,
                        bottom: -2,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            size: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
                title: Text(
                  topic.replaceAll('-', ' ').toUpperCase(),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 15,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
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
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: quizData.length,
              itemBuilder: (context, index) {
                final question = quizData[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF2C3E50), Color(0xFF3498DB)],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'Question ${index + 1}/${quizData.length}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              question['question'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ...question['options'].entries.map((entry) {
                              bool isSelected =
                                  _userAnswers[index] == entry.key;
                              return Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _userAnswers[index] = entry.key;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Colors.white.withOpacity(0.3)
                                            : Colors.white.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.white.withOpacity(0.3),
                                          width: 2,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: isSelected
                                                  ? Colors.white
                                                  : Colors.transparent,
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 2,
                                              ),
                                            ),
                                            child: isSelected
                                                ? const Icon(
                                                    Icons.check,
                                                    size: 16,
                                                    color: Color(0xFF2C3E50),
                                                  )
                                                : null,
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              entry.value,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: isSelected
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 30,
            child: ElevatedButton(
              onPressed: _submitQuiz,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2ECC71),
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(25),
                // ),
                elevation: 5,
              ),
              child: const Text(
                'Submit Quiz',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGeneralInfoContent() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2C3E50), Color(0xFF3498DB)],
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.quiz,
                        size: 60,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Welcome to the Quizzes!",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Test your knowledge and track your progress",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "How to Take the Quiz",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      buildInfoStep(
                        icon: Icons.list,
                        title: "Select a Quiz Topic",
                        description:
                            "Choose from the available quiz topics on the left side menu in desktop mode and from hamburger menu in mobile mode.",
                      ),
                      const SizedBox(height: 15),
                      buildInfoStep(
                        icon: Icons.question_answer,
                        title: "Answer Questions",
                        description:
                            "Read each question carefully and select the best answer from the options provided.",
                      ),
                      const SizedBox(height: 15),
                      buildInfoStep(
                        icon: Icons.check_circle,
                        title: "Submit Your Answers",
                        description:
                            "Click the 'Submit' button after answering all questions to see your results.",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Checking Your Scores",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      buildInfoStep(
                        icon: Icons.desktop_windows,
                        title: "Desktop Mode",
                        description:
                            "Click on the Profile Icon in the app bar at the top of the screen.",
                      ),
                      const SizedBox(height: 15),
                      buildInfoStep(
                        icon: Icons.phone_android,
                        title: "Mobile View",
                        description:
                            "Tap the Hamburger Icon and select 'Profile' from the menu.",
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

  Widget buildInfoStep({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
