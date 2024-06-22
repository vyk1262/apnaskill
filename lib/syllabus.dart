import 'package:flutter/material.dart';

class SyllabusScreen extends StatelessWidget {
  final Map<String, dynamic> subject;

  const SyllabusScreen({Key? key, required this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subject['subject']),
      ),
      body: ListView.builder(
        itemCount: subject['syllabus'].length,
        itemBuilder: (context, index) {
          final module = subject['syllabus'][index];
          return ListTile(
            title: Text(module['module']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: (module['topics'] as List<dynamic>).map((topic) {
                return Text('- $topic');
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
