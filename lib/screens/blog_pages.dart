import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_factorial/custom_app_bar.dart';
import 'package:skill_factorial/widgets/footer.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  final List<Map<String, dynamic>> blogPosts = const [
    {
      'title': 'Applying For Driving Licence Without Test: New 2025 Rules',
      'slug': 'driving-licence-2025',
      'topic': 'Data science',
      'author': 'Skill Factorial - February 02, 2025',
      'subtitle':
          'Get your driving licence without a test under the new 2025 rules...',
      "content": [
        {"type": "heading", "text": "Introduction"},
        {
          "type": "paragraph",
          "text": "Starting in 2025, individuals can apply..."
        },
        {"type": "image", "url": "assets/sf.png"},
        {
          "type": "list",
          "items": [
            "Must be 18 years or older",
            "Must complete an accredited driving course"
          ]
        }
      ],
      'image': 'assets/sf.png',
    },
    {
      'title': 'How To Book Tatkal Ticket: Process And Timing',
      'slug': 'tatkal-ticket-process',
      'topic': 'Data science',
      'author': 'Skill Factorial - February 02, 2025',
      'subtitle': 'Need to book a Tatkal ticket fast? Book online via IRCTC...',
      "content": [
        {"type": "heading", "text": "Introduction"},
        {
          "type": "paragraph",
          "text": "Starting in 2025, individuals can apply..."
        },
        {"type": "image", "url": "assets/sf.png"},
        {
          "type": "list",
          "items": [
            "Must be 18 years or older",
            "Must complete an accredited driving course"
          ]
        }
      ],
      'image': 'assets/sf.png',
    },
    {
      'title': 'SBI E Mudra Loan: Eligibility And Online Application',
      'slug': 'sbi-e-mudra-loan',
      'topic': 'Data science',
      'author': 'Skill Factorial - February 02, 2025',
      'subtitle': 'Secure your business growth with SBI e Mudra Loan...',
      "content": [
        {"type": "heading", "text": "Introduction"},
        {
          "type": "paragraph",
          "text": "Starting in 2025, individuals can apply..."
        },
        {"type": "image", "url": "assets/sf.png"},
        {
          "type": "list",
          "items": [
            "Must be 18 years or older",
            "Must complete an accredited driving course"
          ]
        }
      ],
      'image': 'assets/sf.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView.builder(
        itemCount: blogPosts.length + 1,
        itemBuilder: (context, index) {
          if (index < blogPosts.length) {
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
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 1),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                post['topic']!,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
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
                              post['subtitle']!.substring(0, 50) + '...',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              post['author']!,
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
          } else {
            return Footer();
          }
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
    final post = BlogPage().blogPosts.firstWhere(
          (post) => post['slug'] == slug,
          orElse: () => {},
        );

    return Scaffold(
      appBar: CustomAppBar(),
      body: post.isEmpty
          ? const Center(child: Text('Post not found'))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Post Title
                    Text(
                      post['title'],
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    Text(
                      post['author'],
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 24),

                    Divider(),

                    // Featured Image
                    if (post['image'] != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          post['image'],
                          width: 400,
                          height: 400,
                          fit: BoxFit.cover,
                        ),
                      ),
                    const SizedBox(height: 20),

                    // Author and Date

                    // Content Sections
                    ...(post['content'] as List).map<Widget>((section) {
                      switch (section['type']) {
                        case 'heading':
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              section['text'],
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        case 'paragraph':
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              section['text'],
                              style: const TextStyle(fontSize: 16, height: 1.5),
                            ),
                          );
                        case 'image':
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                section['url'],
                                width: 400,
                                height: 400,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        case 'list':
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Column(
                              children: (section['items'] as List)
                                  .map((item) => Text('• ${item.toString()}'))
                                  .toList(),
                            ),
                          );
                        default:
                          return Container();
                      }
                    }).toList(),
                    Footer(),
                  ],
                ),
              ),
            ),
    );
  }
}
