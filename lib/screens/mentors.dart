import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skill_factorial/custom_app_bar.dart';
import 'mentor_details.dart';

class Mentors extends StatefulWidget {
  const Mentors({super.key});

  @override
  State<Mentors> createState() => _MentorsState();
}

class _MentorsState extends State<Mentors> {
  List<dynamic> mentors = [];

  @override
  void initState() {
    super.initState();
    _loadMentorData();
  }

  Future<void> _loadMentorData() async {
    final String jsonString =
        await rootBundle.loadString('assets/mentors.json');
    final List<dynamic> loadedMentors = jsonDecode(jsonString);

    setState(() {
      mentors = loadedMentors;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: mentors.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: mentors.length,
                itemBuilder: (context, index) {
                  final mentor = mentors[index];
                  return MentorCard(mentor: mentor);
                },
              ),
      ),
    );
  }
}

class MentorCard extends StatelessWidget {
  final dynamic mentor; // Now accepts a dynamic map

  const MentorCard({super.key, required this.mentor});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MentorDetailScreen(mentor: mentor),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50, // Reduced radius for better fit
                  backgroundImage: AssetImage(mentor['image']),
                ),
              ),
              const SizedBox(height: 8), // Reduced spacing
              Text(
                mentor['name'],
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      // Smaller title
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                mentor['profession'],
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 4), // Reduced spacing
              Wrap(
                spacing: 4,
                children: (mentor['expertise'] as List<dynamic>) // Cast to List
                    .map((e) => Chip(
                          label: Text(e),
                          padding: EdgeInsets.zero,
                          labelPadding:
                              const EdgeInsets.symmetric(horizontal: 8),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ))
                    .toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${mentor['price']}/hour',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MentorDetailScreen(mentor: mentor),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
