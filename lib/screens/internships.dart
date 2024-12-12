import 'package:apnaskill/screens/python.dart';
import 'package:apnaskill/tabs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InternshipsHome extends StatefulWidget {
  const InternshipsHome({Key? key}) : super(key: key);

  @override
  State<InternshipsHome> createState() => _InternshipsHomeState();
}

class _InternshipsHomeState extends State<InternshipsHome> {
  Map<String, dynamic>? userData;
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
  List<String> pythonProjects = [
    'python_project_1',
    'python_project_2',
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
  List<String> webProjects = [
    'web_project_1',
    'web_project_2',
    'web_project_3',
    'web_project_4',
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
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: Row(
        children: [
          // User details section (30% of the space)
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.blueGrey[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.logout),
                  label: Text("Logout"),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Tabs()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  ),
                ),
                Text(
                  "User Details",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                if (userData != null) ...[
                  Text("Name: ${userData!['name']}",
                      style: TextStyle(fontSize: 18)),
                  Text("DOB: ${userData!['dateOfBirth']}",
                      style: TextStyle(fontSize: 18)),
                  Text("Gender: ${userData!['gender']}",
                      style: TextStyle(fontSize: 18)),
                  Text("Email: ${userData!['email']}",
                      style: TextStyle(fontSize: 18)),
                ] else
                  CircularProgressIndicator(),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Internship names section (GridView)
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(16.0),
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _buildInternshipCard(context, "Python Programming",
                    pythonQuizTopics, pythonProjects),
                _buildInternshipCard(
                    context, "Web Development", webQuizTopics, webProjects),
                _buildInternshipCard(
                    context, "Data Science", pythonQuizTopics, pythonProjects),
                _buildInternshipCard(context, "Machine Learning",
                    pythonQuizTopics, pythonProjects),
                _buildInternshipCard(context, "Mobile App Development",
                    pythonQuizTopics, pythonProjects),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInternshipCard(BuildContext context, String internshipName,
      List<String> quizList, List<String> projectList) {
    bool isUnlocked = userData?['internshipsList']?.any(
            (internship) => internship['internshipName'] == internshipName) ??
        false;

    return InkWell(
      onTap: () {
        if (isUnlocked) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizScreen(
                internshipName: internshipName,
                quizList: quizList,
                projectList: projectList,
              ),
            ),
          );
        } else {
          _showUnlockDialog(context, internshipName);
        }
      },
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  internshipName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            isUnlocked
                ? Icon(Icons.check_circle, color: Colors.green, size: 40)
                : Column(
                    children: [
                      Icon(Icons.lock, color: Colors.red, size: 40),
                      TextButton(
                        onPressed: () =>
                            _showUnlockDialog(context, internshipName),
                        child: Text("Unlock"),
                      ),
                    ],
                  ),
          ],
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
}
