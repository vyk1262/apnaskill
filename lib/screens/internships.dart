import 'package:apnaskill/home.dart';
import 'package:apnaskill/screens/internship/python.dart';
import 'package:apnaskill/tabs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InternshipsHome extends StatefulWidget {
  const InternshipsHome({Key? key}) : super(key: key);

  @override
  State<InternshipsHome> createState() => _InternshipsHomeState();
}

class _InternshipsHomeState extends State<InternshipsHome> {
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
    'project_1',
    'project_2',
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
    'project_1',
    'project_2',
    'project_3',
    'project_4',
  ];
  @override
  Widget build(BuildContext context) {
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
                  label: Text("Logout"), // Add text label
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut(); // Firebase sign-out
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Tabs(), // Navigate back to the main Tabs widget
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  ),
                ),
                Text(
                  "User  Details",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text("Name: John Doe", style: TextStyle(fontSize: 18)),
                Text("College: ABC University", style: TextStyle(fontSize: 18)),
                Text("Age: 21", style: TextStyle(fontSize: 18)),
                Text("Gender: Male", style: TextStyle(fontSize: 18)),
                Text("State: California", style: TextStyle(fontSize: 18)),
                Text("Department: Computer Science",
                    style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
          const SizedBox(height: 10), // Space between sections

          // Internship names section (GridView)
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(16.0),
              crossAxisCount: 4, // Two items per row
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
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {
          // Navigate to the quizzes and assignments screen
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
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              internshipName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
