import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Assuming go_router is used for navigation
import 'package:url_launcher/url_launcher.dart';

import '../constants/colors.dart'; // To open external links like Google Forms
import 'package:skill_factorial/screens/widgets/custom_app_bar.dart';

import 'widgets/cached_network_image_widget.dart'; // Assuming a custom app bar

class VirtualInternship extends StatefulWidget {
  const VirtualInternship({Key? key}) : super(key: key);

  @override
  State<VirtualInternship> createState() => _VirtualInternshipState();
}

class _VirtualInternshipState extends State<VirtualInternship> {
  final String googleFormLink = 'https://forms.gle/YOUR_GOOGLE_FORM_LINK_HERE';

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $url')),
        );
      }
    }
  }

  final List<Map<String, dynamic>> dailyPlan = [
    // Python Fundamentals
    {
      'day': 1,
      'title': 'Introduction to Python',
      'description':
          'Setting up the environment and understanding the basics of Python.'
    },
    {
      'day': 2,
      'title': 'Basic Syntax and Variables',
      'description':
          'Learn about Python syntax, comments, and declaring variables.'
    },
    {
      'day': 3,
      'title': 'Data Types: Numbers and Strings',
      'description': 'Exploring numerical types and string manipulation.'
    },
    {
      'day': 4,
      'title': 'Conditional Statements: If-Else',
      'description':
          'Understanding control flow with if, elif, and else statements.'
    },
    {
      'day': 5,
      'title': 'Lists: The Basics',
      'description': 'Creating, indexing, and slicing lists.'
    },
    {
      'day': 6,
      'title': 'List Methods',
      'description':
          'Exploring useful list methods like append, extend, and remove.'
    },
    {
      'day': 7,
      'title': 'For Loops',
      'description': 'Iterating over sequences using for loops.'
    },
    {
      'day': 8,
      'title': 'While Loops',
      'description':
          'Using while loops for repeated execution based on a condition.'
    },
    {
      'day': 9,
      'title': 'Tuples and Sets',
      'description': 'Understanding immutable tuples and unordered sets.'
    },
    {
      'day': 10,
      'title': 'Dictionaries',
      'description': 'Working with key-value pairs in dictionaries.'
    },
    {
      'day': 11,
      'title': 'Functions',
      'description': 'Defining and calling functions with arguments.'
    },
    {
      'day': 12,
      'title': 'Advanced Functions',
      'description': 'Exploring lambda functions, args, and kwargs.'
    },
    {
      'day': 13,
      'title': 'String Formatting',
      'description': 'Mastering different ways to format strings.'
    },
    {
      'day': 14,
      'title': 'Error Handling: Try-Except',
      'description': 'Handling exceptions and errors gracefully.'
    },
    {
      'day': 15,
      'title': 'File I/O',
      'description': 'Reading from and writing to files.'
    },
    {
      'day': 16,
      'title': 'Modules and Packages',
      'description':
          'Importing and using modules from the Python Standard Library.'
    },
    {
      'day': 17,
      'title': 'Introduction to NumPy',
      'description': 'Getting started with numerical computing using NumPy.'
    },
    {
      'day': 18,
      'title': 'Introduction to Pandas',
      'description':
          'Learning the basics of data manipulation with Pandas DataFrames.'
    },
    {
      'day': 19,
      'title': 'Data Visualization with Matplotlib',
      'description': 'Creating basic plots and charts.'
    },
    {
      'day': 20,
      'title': 'Important Python Libraries Overview',
      'description':
          'A brief look at other useful libraries like SciPy and Scikit-learn.'
    },

    // AI and Prompt Engineering
    {
      'day': 21,
      'title': 'Introduction to AI and Prompt Engineering',
      'description':
          'Understanding the fundamentals of AI and how to interact with language models.'
    },
    {
      'day': 22,
      'title': 'Advanced AI Tools and Techniques',
      'description':
          'Exploring ChatGPT, and other AI tools for developers. Crafting effective prompts.'
    },

    // Projects
    {
      'day': 23,
      'title': 'Project 1: Personal Portfolio Website',
      'description':
          'Start building a personal portfolio website to showcase your skills and projects. \nA professional website to showcase your personal information, educational qualifications, work experience, and the projects you build during this internship.'
    },
    {
      'day': 24,
      'title': 'Project 2: Calculator App',
      'description':
          'Develop a graphical calculator with basic arithmetic operations. \nA fully functional calculator application with a user-friendly interface that can perform addition, subtraction, multiplication, and division.'
    },
    {
      'day': 25,
      'title': 'Project 3: To-Do List Application',
      'description':
          'Create an app to manage daily tasks with deadlines and completion status. \nA task management application where you can add tasks with due dates, mark them as complete, and remove them from the list.'
    },
    {
      'day': 26,
      'title': 'Project 4: Number Guessing Game',
      'description':
          'Build a fun game where the user has to guess a randomly generated number. \nAn interactive console-based game where the program generates a random number and the user has to guess it within a certain number of tries.'
    },
    {
      'day': 27,
      'title': 'Project 5: Simple Weather App',
      'description':
          'Create an application to display the current weather of a city using a public API. \nAn application that fetches and displays the current weather forecast for a specified city by integrating with a free weather API.'
    },

    // Deployment and Final Submission
    {
      'day': 28,
      'title': 'Version Control with Git and GitHub',
      'description':
          'Learn the essentials of Git for tracking changes and collaborating on projects using GitHub.'
    },
    {
      'day': 29,
      'title': 'Deploying Your Website',
      'description':
          'Deploy your portfolio website to a hosting service to make it publicly accessible.'
    },
    {
      'day': 30,
      'title': 'Final Project Submission and Review',
      'description':
          'Submit your completed projects for review and receive feedback.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Skill Factorial: 1-Month Python Virtual Internship',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Embark on a hands-on journey to master essential tech skills. Build real-world projects and boost your career.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              _buildSectionTitle(context, 'Daily Learning Plan'),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dailyPlan.length,
                itemBuilder: (context, index) {
                  final item = dailyPlan[index];
                  return _buildDailyPlanItem(
                    context,
                    day: item['day'],
                    title: item['title'],
                    description: item['description'],
                  );
                },
              ),
              const SizedBox(height: 24),
              _buildCenteredSection(context, title: '--- Register Now ---'),
              const SizedBox(height: 16),
              _buildCenteredSection(context, title: 'Just Rupees: 499/-'),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => _launchURL(googleFormLink),
                icon: const Icon(Icons.app_registration),
                label: const Text('Register via Google Form',
                    style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                  shadowColor:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 32),
              _buildCenteredSection(
                context,
                title: '--- Internship Certificate ---',
                content:
                    'Get a verified internship certificate from Skill Factorial upon successful completion.',
              ),
              const CachedNetworkImageWidget(
                imageUrl: "https://i.ibb.co/S4pwHMDr/javascript.png",
                width: double.infinity,
                fit: BoxFit.cover,
                errorWidget: Icon(Icons.broken_image),
              ),
              const SizedBox(height: 32),
              _buildCenteredSection(context, title: '--- Register Now ---'),
              const SizedBox(height: 16),
              _buildCenteredSection(context, title: 'Just Rupees: 499/-'),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => _launchURL(googleFormLink),
                icon: const Icon(Icons.app_registration),
                label: const Text('Register via Google Form',
                    style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                  shadowColor:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Center(
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildDailyPlanItem(BuildContext context,
      {required int day, required String title, required String description}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
            width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Text('$day',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenteredSection(BuildContext context,
      {required String title, String content = ''}) {
    return Center(
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
            textAlign: TextAlign.center,
          ),
          if (content.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              content,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ]
        ],
      ),
    );
  }
}
