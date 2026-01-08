import 'dart:convert';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:skill_factorial/screens/common_widgets/title_case.dart';

import '../constants/colors.dart';
import 'quiz_page_widgets/general_info_content.dart';
import 'quiz_page_widgets/viewResponses.dart';
import 'package:http/http.dart' as http;
import 'package:skill_factorial/api_service.dart';

class CourseContentScreen extends StatefulWidget {
  final String internshipName;
  final List<String> quizList;

  const CourseContentScreen({
    Key? key,
    required this.internshipName,
    required this.quizList,
  }) : super(key: key);

  @override
  State<CourseContentScreen> createState() => _CourseContentScreenState();
}

class _CourseContentScreenState extends State<CourseContentScreen> {
  List<String?> _userAnswers = [];
  List<Map<String, dynamic>> quizData = [];
  List<Map<String, dynamic>> projectData = [];
  List<Map<String, dynamic>> assignmentData = [];
  bool showGeneralInfo = true;

  // Timer state for quizzes (20 minutes)
  Timer? _quizTimer;
  int _remainingSeconds = 10 * 60;
  bool _timerRunning = false;
  bool _autoSubmitted = false;

  String? selectedQuiz; // Default selected quiz topic
  String? selectedAssignment; // Track selected assignment
  String? selectedProjectWeek;
  bool showProjects = false;
  List<String> completedQuizzes = [];
  bool _showSidebarMobile = false;
  // Cache for the whole course JSON to avoid repeated network calls
  final Map<String, List<Map<String, dynamic>>> _topicsMap = {};
  bool _isCourseJsonLoaded = false;
  bool _isCourseJsonLoading = false;

  @override
  void initState() {
    super.initState();
    showGeneralInfo = true;
    _loadCompletedItems();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  Future<void> _loadQuizData(String topic) async {
    // Ensure whole course JSON is loaded and cached, then pick topic data.
    try {
      await _ensureCourseJsonLoaded();

      final selectedTopicQuestions = _topicsMap[topic];
      if (selectedTopicQuestions == null) {
        throw Exception(
            'Topic "${topic}" not found in ${widget.internshipName}');
      }

      setState(() {
        quizData = List<Map<String, dynamic>>.from(selectedTopicQuestions);
        _userAnswers =
            List<String?>.filled(quizData.length, null, growable: false);
        selectedAssignment = null;
        _showSidebarMobile = false;
      });

      // Start/reset the quiz timer whenever a quiz loads
      _startTimer();
    } catch (e) {
      print('❌ Error loading quiz data: $e');
    }
  }

  /// Loads and caches the entire course JSON from Firebase Storage once.
  Future<void> _ensureCourseJsonLoaded() async {
    if (_isCourseJsonLoaded || _isCourseJsonLoading) return;
    _isCourseJsonLoading = true;
    try {
      final ref = FirebaseStorage.instance.ref().child(
          'quiz_data/${widget.internshipName.toLowerCase().replaceAll(' ', '_')}.json');
      final url = await ref.getDownloadURL();
      final response = await http.get(Uri.parse(url));

      if (response.statusCode != 200) {
        throw Exception('Failed to load course JSON: ${response.statusCode}');
      }

      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final List<dynamic> topics = jsonData['result'] ?? [];

      _topicsMap.clear();
      for (var t in topics) {
        final String tName = t['topic'] as String? ?? '';
        final List<dynamic> questions = t['questions'] ?? [];
        _topicsMap[tName] = List<Map<String, dynamic>>.from(questions);
      }

      _isCourseJsonLoaded = true;
    } catch (e) {
      print('❌ Error loading course JSON: $e');
      rethrow;
    } finally {
      _isCourseJsonLoading = false;
    }
  }

  Future<void> _loadProjectData(String week) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(
          'quiz_data/${widget.internshipName.toLowerCase().replaceAll(' ', '_')}_projects.json');
      final url = await ref.getDownloadURL();
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        final List<dynamic> projects = jsonData['result'];
        final selectedProject = projects.firstWhere((p) => p['week'] == week);

        setState(() {
          projectData =
              List<Map<String, dynamic>>.from(selectedProject['instructions']);
          selectedProjectWeek = week;
          showProjects = true;
          selectedQuiz = null;
        });
      }
    } catch (e) {
      print('Project not found: $e');
    }
  }

  Future<void> _loadCompletedItems() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Map<String, dynamic>? userData = await ApiService.getUserData(user.uid);

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

  String _formatDuration(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void _startTimer() {
    _stopTimer();
    setState(() {
      _remainingSeconds = 10 * 60; // reset to 20 minutes
      _timerRunning = true;
      _autoSubmitted = false;
    });
    _quizTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        }
      });
      if (_remainingSeconds <= 0) {
        timer.cancel();
        setState(() {
          _timerRunning = false;
          _autoSubmitted = true;
        });
        // Auto-submit when timer reaches zero
        try {
          _submitQuiz();
        } catch (_) {}
      }
    });
  }

  void _stopTimer() {
    _quizTimer?.cancel();
    _quizTimer = null;
    _timerRunning = false;
  }

  void _submitQuiz() async {
    // stop timer to avoid duplicate auto-submit
    _stopTimer();
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
      'total_questions': quizData.length,
    };

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await ApiService.addOrUpdateQuizMark(
            user.uid, widget.internshipName, quizEntry);
        // Refresh local completed quizzes
        await _loadCompletedItems();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Quiz saved successfully.')),
          );
        }
      } catch (e) {
        debugPrint('Failed to save quiz marks: $e');
        if (mounted)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to save quiz marks: $e')),
          );
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
                // After submission, advance to next quiz if available
                final currentTopic = quizName;
                final currentIndex = widget.quizList.indexOf(currentTopic);
                if (currentIndex >= 0 &&
                    currentIndex < widget.quizList.length - 1) {
                  final nextTopic = widget.quizList[currentIndex + 1];
                  setState(() {
                    selectedQuiz = nextTopic;
                    showGeneralInfo = false;
                  });
                  // load next quiz data and refresh completed list
                  _loadQuizData(nextTopic);
                  _loadCompletedItems();
                } else {
                  // No next quiz -> go back to overview
                  setState(() {
                    showGeneralInfo = true;
                    selectedQuiz = '';
                  });
                  _loadCompletedItems();
                }
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
    final bool showSubmitButton = !showGeneralInfo && quizData.isNotEmpty;

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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: showSubmitButton
          ? Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: FloatingActionButton.extended(
                backgroundColor: const Color(0xFF2ECC71),
                onPressed: _submitQuiz,
                label: Text(
                  _timerRunning
                      ? '${_formatDuration(_remainingSeconds)}  SUBMIT'
                      : 'SUBMIT QUIZ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                    color: Colors.white,
                  ),
                ),
                icon: const Icon(Icons.check_circle),
              ),
            )
          : null,
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
              onPressed: () {
                _stopTimer();
                Navigator.pop(context);
              },
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
                _stopTimer();
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
              margin: const EdgeInsets.symmetric(vertical: 2),
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
                  vertical: 4,
                ),
                leading: Icon(
                  Icons.assignment_outlined,
                  color: Colors.white.withOpacity(0.9),
                  size: 26,
                ),
                title: Text(
                  toTitleCase(topic),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 15,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
                trailing: Icon(
                  isCompleted ? Icons.check : Icons.arrow_forward,
                  color: isCompleted
                      ? Colors.green
                      : Colors.white.withOpacity(0.9),
                  size: isCompleted ? 24 : 18,
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
    // 1. Determine the key for the current content state.
    // This key MUST change when the content needs to animate.
    final Key contentKey =
        ValueKey(showGeneralInfo ? 'GeneralInfo' : selectedQuiz ?? 'Loading');

    // 2. Define the current content widget based on the state.
    Widget currentContent;
    if (showGeneralInfo) {
      currentContent = buildGeneralInfoContent(key: contentKey);
    } else if (selectedQuiz != null && quizData.isNotEmpty) {
      // Pass the unique key here to trigger the animation when selectedQuiz changes.
      currentContent = buildQuizContent(key: contentKey);
    } else {
      // Show loading state if a quiz is selected but data hasn't loaded yet.
      currentContent = Center(
        key: contentKey, // Use the unique key for loading state too
        child: const CircularProgressIndicator(color: Color(0xFF3498DB)),
      );
    }

    // 3. Wrap the content with AnimatedSwitcher
    //
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 2000),
      reverseDuration: const Duration(
          milliseconds: 100), // Speed up the exit slightly for snappiness
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,

      // THIS IS THE KEY FIX:
      // It prevents the "jump" by centering the widgets in the transition stack.
      layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
        return Stack(
          alignment: Alignment.topCenter, // Keep everything anchored to the top
          children: <Widget>[
            ...previousChildren,
            if (currentChild != null) currentChild,
          ],
        );
      },

      transitionBuilder: (Widget child, Animation<double> animation) {
        // Combine Fade with a very slight Scale for a "Premium" feel
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.98, end: 1.0).animate(animation),
            child: child,
          ),
        );
      },
      child: currentContent,
    );
  }

  Widget buildQuizContent({Key? key}) {
    return Container(
      key: key,
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
                                            ? Colors.black.withOpacity(0.5)
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
          // const SizedBox(height: 10),
          // Container(
          //   width: double.infinity,
          //   height: 30,
          //   child: ElevatedButton(
          //     onPressed: _submitQuiz,
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: const Color(0xFF2ECC71),
          //       // shape: RoundedRectangleBorder(
          //       //   borderRadius: BorderRadius.circular(25),
          //       // ),
          //       elevation: 5,
          //     ),
          //     child: const Text(
          //       'Submit Quiz',
          //       style: TextStyle(
          //         fontSize: 15,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
