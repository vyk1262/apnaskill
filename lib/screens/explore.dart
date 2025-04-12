import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../custom_app_bar.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  String _searchQuery = '';
  Map<String, List<Map<String, String>>> _filteredExploreData = {};
  Map<String, List<Map<String, String>>> _exploreData = {};

  @override
  void initState() {
    super.initState();
    _loadExploreData();
    _filteredExploreData = _exploreData; // Initially show all data
  }

  Future<void> _loadExploreData() async {
    try {
      final String jsonData =
          await rootBundle.loadString('assets/explore.json');
      final Map<String, dynamic> decodedData = json.decode(jsonData);

      final Map<String, List<Map<String, String>>> typedData = {};
      decodedData.forEach((key, dynamic value) {
        if (value is List) {
          List<Map<String, String>> linkList = [];
          for (var item in value) {
            if (item is Map) {
              // Explicitly check if the map has String keys and values
              if (item.keys.every((k) => k is String) &&
                  item.values.every((v) => v is String)) {
                linkList.add(item.cast<String, String>());
              } else {
                print(
                    'Warning: Skipping item in category "$key" due to incorrect type: $item');
              }
            } else {
              print('Warning: Skipping non-map item in category "$key": $item');
            }
          }
          typedData[key] = linkList;
        }
      });

      setState(() {
        _exploreData = typedData;
        _filteredExploreData = typedData;
      });
    } catch (e) {
      print('Error loading explore data: $e');
      // Handle error appropriately, e.g., display an error message
    }
  }

  void _filterData(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredExploreData = _exploreData;
      } else {
        _filteredExploreData = {};
        _exploreData.forEach((category, links) {
          _filteredExploreData[category] = links.where((link) {
            final title = link['title']?.toLowerCase() ?? '';
            final url = link['url']?.toLowerCase() ?? '';
            final lowerQuery = query.toLowerCase();
            return title.contains(lowerQuery) || url.contains(lowerQuery);
          }).toList();
        });
        // Remove categories with no matching links
        _filteredExploreData.removeWhere((key, value) => value.isEmpty);
      }
    });
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  Widget _buildLinkCard(String title, String url) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        onTap: () => _launchURL(url),
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.open_in_new,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _exploreData.entries.map((entry) {
            final category = entry.key;
            final links = entry.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle(category),
                GridView.extent(
                  maxCrossAxisExtent: 200.0,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: links
                      .map((link) => _buildLinkCard(
                            link['title']!,
                            link['url']!,
                          ))
                      .toList(),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
