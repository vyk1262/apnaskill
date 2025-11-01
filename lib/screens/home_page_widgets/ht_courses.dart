import 'package:flutter/material.dart';

class CoursesSection extends StatelessWidget {
  // Data for the Courses Section
  final Map<String, dynamic> pageData = const {
    'coreCourses': {
      'title': "Our Core Courses",
      'courses': [
        {
          'emoji': "🐍",
          'title': "Python",
          'description':
              "Learn the most popular language for data analysis, machine learning, and automation.",
        },
        {
          'emoji': "📊",
          'title': "SQL",
          'description':
              "Master the language of databases to query, manage, and analyze large datasets efficiently.",
        },
        {
          'emoji': "📈",
          'title': "Power BI",
          'description':
              "Create stunning, interactive data visualizations and business intelligence reports.",
        },
        {
          'emoji': "🧠",
          'title': "DSA",
          'description':
              "Build a strong foundation in Data Structures and Algorithms for technical interviews.",
        },
        {
          'emoji': "🤖",
          'title': "Machine Learning Fundamentals",
          'description':
              "An introduction to the core concepts and algorithms of machine learning. Learn to build predictive models.",
        },
        {
          'emoji': "☁️",
          'title': "Cloud Computing Essentials",
          'description':
              "Get started with the basics of cloud platforms like AWS and Azure. Understand cloud infrastructure and services.",
        },
        {
          'emoji': "🕸️",
          'title': "Web Development Basics",
          'description':
              "A comprehensive course on HTML, CSS, and JavaScript to build modern and responsive websites from scratch.",
        },
        {
          'emoji': "💻",
          'title': "C++ Programming",
          'description':
              "Dive deep into C++, a powerful language for systems programming, game development, and high-performance computing.",
        },
      ],
    },
  };

  const CoursesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final courses = pageData['coreCourses']['courses'] as List;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 64.0),
      color: Colors.white, // Corresponds to `bg-gray-50` or `bg-white`
      child: Center(
        child: Column(
          children: [
            Text(
              pageData['coreCourses']['title']!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1f2937),
              ),
            ),
            const SizedBox(height: 48.0),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400.0,
                childAspectRatio: 1.0,
                crossAxisSpacing: 24.0,
                mainAxisSpacing: 24.0,
              ),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return _buildCourseCard(course);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseCard(Map<String, String> course) {
    return Card(
      elevation: 8.0,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(32.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              course['emoji']!,
              style: const TextStyle(fontSize: 48.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              course['title']!,
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1f2937),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: Text(
                course['description']!,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Color(0xFF4b5563),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // TODO: Handle enrollment
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF14b8a6), // Teal 500
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9999.0),
                ),
              ),
              child: const Text(
                'Enroll Now 499/-',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
