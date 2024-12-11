import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:html' as html;

class Courses extends StatefulWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  List<dynamic> courses = [];
  bool isLoading = true;
  Map<String, dynamic>? selectedCourse;

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

  void selectCourse(Map<String, dynamic> course) {
    setState(() {
      selectedCourse = course;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Flexible(
            flex: 1,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
                ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    final course = courses[index];
                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.all(8.0),
                            leading: Icon(Icons.book,
                                size: 40,
                                color: Theme.of(context).primaryColor),
                            title: Text(
                              course['subject'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () => selectCourse(course),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Flexible(
            flex: 3,
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(8.0),
                  child: selectedCourse != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: selectedCourse!['syllabus'].length,
                              itemBuilder: (context, index) {
                                final module =
                                    selectedCourse!['syllabus'][index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    elevation: 2,
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
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: (module['topics']
                                                    as List<dynamic>)
                                                .map((topic) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4.0),
                                                child: Text(
                                                  '- $topic',
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                      : const Center(
                          child: Text(
                            'Select a course to view the syllabus',
                            style: TextStyle(
                                fontSize: 18, fontStyle: FontStyle.italic),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
