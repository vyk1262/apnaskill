import 'package:apnaskill/widgets/subjects_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:apnaskill/syllabus.dart';
import 'package:apnaskill/widgets/header.dart';
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
    fetchSyllabus();
  }

  void openUrl(String url) {
    html.window.open(url, '_blank');
  }

  Future<void> fetchSyllabus() async {
    final response = await http.get(Uri.parse(
        'https://gist.githubusercontent.com/vyk1262/236b5ea8345cd64eeaba112cfe807b77/raw/4dcff7230329d4752810924fa53656bc0b83b2b6/subjects.json'));

    if (response.statusCode == 200) {
      setState(() {
        syllabus = json.decode(response.body)['result'];
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load syllabus');
    }
  }

  void navigateToSyllabusScreen(Map<String, dynamic> subject) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SyllabusScreen(subject: subject),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Apply for an internship and get certified after completion',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      const url = 'https://forms.gle/gqaYp61V1B4XQPwu7';
                      openUrl(url);
                    },
                    child: const Text('Click here'),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6, // Adjust the number of columns
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: syllabus.length,
                      itemBuilder: (context, index) {
                        final subject = syllabus[index];
                        return SubjectButton(
                          subject: subject['subject'],
                          onTap: () => navigateToSyllabusScreen(subject),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
