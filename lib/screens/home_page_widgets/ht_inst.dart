import 'package:flutter/material.dart';

class InstructorsSection extends StatelessWidget {
  // Data for the Instructors Section
  final Map<String, dynamic> pageData = const {
    'instructors': {
      'title': "Meet Our Instructors",
      'team': [
        {
          'imageSrc': "https://i.ibb.co/bM457PyY/row-thumb-a.png",
          'name': "Joe Smith",
          'role': "Lead Data Scientist",
          'bio':
              "Joe has over 10 years of experience in data analytics and is passionate about teaching Python and machine learning.",
        },
        {
          'imageSrc': "https://i.ibb.co/r28pcYx0/row-cmp-a.png",
          'name': "Jane Doe",
          'role': "Senior BI Analyst",
          'bio':
              "Jane specializes in business intelligence and helps students master Power BI and SQL for impactful data storytelling.",
        },
        {
          'imageSrc': "https://i.ibb.co/vC51sHv4/row-cmp-d.png",
          'name': "Alex Chen",
          'role': "Software Engineer",
          'bio':
              "Alex is a competitive programmer with a knack for Data Structures and Algorithms, preparing students for technical interviews.",
        },
      ],
    },
  };

  const InstructorsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final instructors = pageData['instructors']['team'] as List;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 64.0),
      color: const Color.fromARGB(
          255, 29, 105, 211), // Corresponds to `bg-gray-900`
      child: Column(
        children: [
          Text(
            pageData['instructors']['title']!,
            style: const TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 48.0),
          LayoutBuilder(
            builder: (context, constraints) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: constraints.maxWidth > 900
                      ? 3
                      : constraints.maxWidth > 600
                          ? 2
                          : 1,
                  crossAxisSpacing: 32.0,
                  mainAxisSpacing: 32.0,
                  childAspectRatio: 0.8, // Adjust as needed
                ),
                itemCount: instructors.length,
                itemBuilder: (context, index) {
                  final instructor = instructors[index];
                  return _buildInstructorCard(instructor);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInstructorCard(Map<String, String> instructor) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1e293b), // A slightly lighter dark gray
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.network(
              instructor['imageSrc']!,
              width: 96.0,
              height: 96.0,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            instructor['name']!,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            instructor['role']!,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2dd4bf), // var(--color-secondary-light)
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            instructor['bio']!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14.0,
              color: Color(0xFF9ca3af), // Gray 400
            ),
          ),
        ],
      ),
    );
  }
}
