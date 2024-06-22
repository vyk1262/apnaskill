import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:apnaskill/syllabus.dart';
import 'package:apnaskill/widgets/header.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> syllabus = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSyllabus();
  }

  Future<void> fetchSyllabus() async {
    final response = await http.get(Uri.parse(
        'https://run.mocky.io/v3/4005280c-4ff7-4fd7-89d8-5e917d7ad922'));

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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: syllabus.length,
              itemBuilder: (context, index) {
                final subject = syllabus[index];
                return ListTile(
                  title: Text(subject['subject']),
                  onTap: () => navigateToSyllabusScreen(subject),
                );
              },
            ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: const Center(child: Text('Home Screen')),
    );
  }
}
