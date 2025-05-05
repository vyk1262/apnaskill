import 'package:flutter/material.dart';
import 'package:skill_factorial/constants/colors.dart';
import 'package:skill_factorial/custom_app_bar.dart';
import 'package:skill_factorial/widgets/footer.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({Key? key}) : super(key: key);

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  final List<Map<String, dynamic>> jobs = [
    {
      'title': 'Flutter Developer',
      'company': 'Tech Solutions Inc.',
      'location': 'Remote',
      'type': 'Full-time',
      'description':
          'We are looking for an experienced Flutter developer to join our team.',
      'requirements': [
        'Experience with Flutter and Dart',
        'Knowledge of state management',
        'Understanding of REST APIs'
      ],
      'salary': '80,000 - 120,000'
    },
    {
      'title': 'Frontend Developer',
      'company': 'Digital Innovations',
      'location': 'New York',
      'type': 'Contract',
      'description': 'Frontend developer needed for exciting web projects.',
      'requirements': [
        'React.js experience',
        'CSS and responsive design',
        'JavaScript expertise'
      ],
      'salary': '70,000 - 100,000'
    },
    {
      'title': 'Backend Engineer',
      'company': 'Cloud Systems',
      'location': 'San Francisco',
      'type': 'Full-time',
      'description':
          'Looking for a backend engineer to build scalable systems.',
      'requirements': [
        'Node.js expertise',
        'Database design',
        'AWS experience'
      ],
      'salary': '90,000 - 140,000'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24.0),
              color: AppColors.primaryColor.withOpacity(0.1),
              child: Column(
                children: [
                  const Text(
                    'Find Your Dream Job',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search jobs...',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Latest Job Openings',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: jobs.length,
                    itemBuilder: (context, index) {
                      final job = jobs[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    job['title'],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Chip(
                                    label: Text(job['type']),
                                    backgroundColor:
                                        AppColors.primaryColor.withOpacity(0.1),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                job['company'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.location_on, size: 16),
                                  const SizedBox(width: 4),
                                  Text(job['location']),
                                  const SizedBox(width: 16),
                                  const Icon(Icons.attach_money, size: 16),
                                  const SizedBox(width: 4),
                                  Text(job['salary']),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                job['description'],
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Requirements:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Column(
                                children: [
                                  for (var requirement in job['requirements'])
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 4),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.check_circle,
                                              size: 16,
                                              color: AppColors.primaryColor),
                                          const SizedBox(width: 8),
                                          Text(requirement),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                ),
                                child: const Text('Apply Now'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Footer(),
          ],
        ),
      ),
    );
  }
}
