import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skill_factorial/custom_app_bar.dart';
import 'package:skill_factorial/screens/custom_search_bar.dart';
import 'package:skill_factorial/widgets/cached_network_image_widget.dart';
import 'package:skill_factorial/widgets/home_page_widgets/cta_button.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogHomeScreen extends StatefulWidget {
  const BlogHomeScreen({super.key});

  @override
  State<BlogHomeScreen> createState() => _BlogHomeScreenState();
}

class _BlogHomeScreenState extends State<BlogHomeScreen> {
  List<dynamic> _allBlogs = [];
  List<dynamic> _filteredBlogs = [];
  TextEditingController _searchController = TextEditingController();
  int? _hoveredIndex;

  @override
  void initState() {
    super.initState();
    _loadBlogData();
    _searchController.addListener(_filterBlogs);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadBlogData() async {
    final String response =
        await rootBundle.loadString('assets/blog_data.json');
    setState(() {
      _allBlogs = json.decode(response);
      _filteredBlogs = List.from(_allBlogs);
    });
  }

  void _filterBlogs() {
    String searchTerm = _searchController.text.toLowerCase();
    setState(() {
      _filteredBlogs = _allBlogs.where((blog) {
        final title = (blog['title'] as String).toLowerCase();
        return title.contains(searchTerm);
      }).toList();
    });
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomSearchBar(
                controller: _searchController, hintText: 'Search articles...'),
            const SizedBox(height: 16),
            Expanded(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  int crossAxisCount = 1;
                  if (constraints.maxWidth >= 600) {
                    crossAxisCount = 2;
                  }
                  if (constraints.maxWidth >= 900) {
                    crossAxisCount = 3;
                  }
                  if (constraints.maxWidth >= 1200) {
                    crossAxisCount = 4;
                  }

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: 1.0, // Adjust as needed
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: _filteredBlogs.length,
                    itemBuilder: (context, index) {
                      final blog = _filteredBlogs[index];
                      return MouseRegion(
                        cursor: SystemMouseCursors.click,
                        onEnter: (_) => setState(() => _hoveredIndex = index),
                        onExit: (_) => setState(() => _hoveredIndex = null),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          transform: Matrix4.identity()
                            ..scale(_hoveredIndex == index ? 1.03 : 1.0),
                          child: InkWell(
                            onTap: () {
                              _launchURL(blog['articleLink']);
                            },
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        Positioned.fill(
                                          child: CachedNetworkImageWidget(
                                            imageUrl: blog['image'],
                                            fit: BoxFit.cover,
                                            errorWidget:
                                                const Icon(Icons.broken_image),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          blog['title'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        if (blog['category'] != null)
                                          Text(
                                            "#${blog['category']}",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        const SizedBox(height: 4),
                                        if (blog['description'] != null)
                                          Text(
                                            blog['description'],
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            if (blog['date'] != null)
                                              Text(
                                                blog['date'],
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[700],
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            if (blog['readTime'] != null)
                                              Text(
                                                blog['readTime'],
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[700],
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
