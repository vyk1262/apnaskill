import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class Courses extends StatefulWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  List<dynamic> courses = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSyllabusFromLocal();
  }

  Future<void> fetchSyllabusFromLocal() async {
    try {
      final String response =
          await rootBundle.loadString('assets/api-data.json');
      final data = json.decode(response);

      setState(() {
        courses = data['result'];
        isLoading = false;
      });
    } catch (e) {
      print('Error loading local JSON: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200, // Maximum width of each grid item
                crossAxisSpacing: 8.0, // Spacing between columns
                mainAxisSpacing: 8.0, // Spacing between rows
                childAspectRatio: 1.5, // Adjust for the card dimensions
              ),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SyllabusScreen(course: course),
                    ),
                  ),
                  child: Card(
                    elevation: 4,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.book,
                                size: 40,
                                color: Theme.of(context).primaryColor),
                            const SizedBox(height: 8),
                            Text(
                              course['subject'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class SyllabusScreen extends StatelessWidget {
  final Map<String, dynamic> course;

  const SyllabusScreen({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(course['subject'])),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: course['syllabus'].length,
        itemBuilder: (context, index) {
          final module = course['syllabus'][index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListTile(
                title: Text(
                  module['module'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: (module['topics'] as List<dynamic>).map((topic) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          '- $topic',
                          style: const TextStyle(fontSize: 16),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
