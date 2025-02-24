import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import '../custom_app_bar.dart';

class SyllabusScreen extends StatelessWidget {
  final String internshipName;
  final dynamic syllabusData;

  const SyllabusScreen(
      {Key? key, required this.internshipName, required this.syllabusData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> syllabus =
        syllabusData is List ? List<dynamic>.from(syllabusData) : [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text('${internshipName} Syllabus'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: syllabus.isNotEmpty
            ? ListView.separated(
                itemCount: syllabus.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final module = syllabus[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      // Added Padding inside Card
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Align text to the start
                        children: [
                          Text(
                            module['module'] ?? "",
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18), // Increased font size
                          ),
                          const SizedBox(
                              height: 8), // Spacing between module and topics
                          ...(module['topics'] as List)
                              .map((topic) => Padding(
                                    // Added Padding for topics
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4), // Spacing between topics
                                    child: Text(topic,
                                        style: const TextStyle(fontSize: 16)),
                                  ))
                              .toList(),
                        ],
                      ),
                    ),
                  );
                },
              )
            : const Center(
                child: Text("Syllabus not found for this internship."),
              ),
      ),
    );
  }
}
