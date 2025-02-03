import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_factorial/custom_app_bar.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  final List<Map<String, String>> blogPosts = const [
    {
      'title': 'Applying For Driving Licence Without Test: New 2025 Rules',
      'slug': 'driving-licence-2025',
      'content':
          'Get your driving licence without a test under the new 2025 rules...',
      'image': 'assets/sf.png',
    },
    {
      'title': 'How To Book Tatkal Ticket: Process And Timing',
      'slug': 'tatkal-ticket-process',
      'content': 'Need to book a Tatkal ticket fast? Book online via IRCTC...',
      'image': 'assets/sf.png',
    },
    {
      'title': 'SBI E Mudra Loan: Eligibility And Online Application',
      'slug': 'sbi-e-mudra-loan',
      'content': 'Secure your business growth with SBI e Mudra Loan...',
      'image': 'assets/sf.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView.builder(
        itemCount: blogPosts.length,
        itemBuilder: (context, index) {
          final post = blogPosts[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 3,
            child: InkWell(
              onTap: () => context.go('/blog/${post['slug']}'),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 12),
                    // Text content section
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            post['title']!,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            post['content']!.substring(0, 50) + '...',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Date: ${DateTime.now().toString()}",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Image section with fixed dimensions
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        post['image']!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class BlogPostPage extends StatelessWidget {
  final String slug;

  const BlogPostPage({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    // Fetch blog content based on slug (In a real app, this would be from API or database)
    final post = BlogPage()
        .blogPosts
        .firstWhere((post) => post['slug'] == slug, orElse: () => {});

    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              post['image'] != null
                  ? Image.asset(post['image']!, fit: BoxFit.cover)
                  : Container(),
              const SizedBox(height: 16),
              Text(post['title'] ?? '',
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text(post['content'] ?? ''),
            ],
          ),
        ),
      ),
    );
  }
}
