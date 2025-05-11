import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class UniversitiesScreen extends StatefulWidget {
  const UniversitiesScreen({Key? key}) : super(key: key);

  @override
  _UniversitiesScreenState createState() => _UniversitiesScreenState();
}

class _UniversitiesScreenState extends State<UniversitiesScreen>
    with SingleTickerProviderStateMixin {
  Map<String, dynamic> universitiesData = {};
  List<String> countries = [];
  List<String> states = [];
  List<Map<String, dynamic>> filteredUniversities = [];
  String? selectedCountry;
  String? selectedState;
  String searchQuery = '';
  bool isLoading = true;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    loadUniversityData();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> loadUniversityData() async {
    try {
      final String jsonData =
          await rootBundle.loadString('assets/universities.json');
      final Map<String, dynamic> data = json.decode(jsonData);
      setState(() {
        universitiesData = data['countries'];
        countries = universitiesData.keys.toList()..sort();
        isLoading = false;
      });
      filterUniversities();
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error loading university data')),
        );
      }
    }
  }

  void updateStates() {
    if (selectedCountry != null && universitiesData[selectedCountry] != null) {
      setState(() {
        states = universitiesData[selectedCountry]['states'].keys.toList()
          ..sort();
        selectedState = null;
      });
    } else {
      setState(() {
        states = [];
        selectedState = null;
      });
    }
    filterUniversities();
  }

  void filterUniversities() {
    List<Map<String, dynamic>> universities = [];
    if (selectedCountry != null) {
      final countryData = universitiesData[selectedCountry];
      if (selectedState != null) {
        universities = List<Map<String, dynamic>>.from(
            countryData['states'][selectedState]);
      } else {
        countryData['states'].forEach((state, unis) {
          universities.addAll(List<Map<String, dynamic>>.from(unis));
        });
      }
    } else {
      universitiesData.forEach((country, data) {
        data['states'].forEach((state, unis) {
          universities.addAll(List<Map<String, dynamic>>.from(unis));
        });
      });
    }

    if (searchQuery.isNotEmpty) {
      universities = universities
          .where((uni) => uni['name']
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase()))
          .toList();
    }

    setState(() {
      filteredUniversities = universities;
    });
    _animationController.reset();
    _animationController.forward();
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $url')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Universities Worldwide'),
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Search universities...',
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                          filterUniversities();
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: selectedCountry,
                              decoration: InputDecoration(
                                labelText: 'Country',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              items:
                                  [null, ...countries].map((String? country) {
                                return DropdownMenuItem(
                                  value: country,
                                  child: Text(country ?? 'All Countries'),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  selectedCountry = value;
                                });
                                updateStates();
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: selectedState,
                              decoration: InputDecoration(
                                labelText: 'State',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              items: [null, ...states].map((String? state) {
                                return DropdownMenuItem(
                                  value: state,
                                  child: Text(state ?? 'All States'),
                                );
                              }).toList(),
                              onChanged: states.isEmpty
                                  ? null
                                  : (String? value) {
                                      setState(() {
                                        selectedState = value;
                                      });
                                      filterUniversities();
                                    },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: filteredUniversities.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.school_outlined,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No universities found',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        )
                      : AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return ListView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: filteredUniversities.length,
                              itemBuilder: (context, index) {
                                final university = filteredUniversities[index];
                                return FadeTransition(
                                  opacity: _animation,
                                  child: SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(0, 0.1),
                                      end: Offset.zero,
                                    ).animate(_animation),
                                    child: Card(
                                      elevation: 4,
                                      margin: const EdgeInsets.only(bottom: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: InkWell(
                                        onTap: () =>
                                            _launchUrl(university['website']),
                                        borderRadius: BorderRadius.circular(15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                top: Radius.circular(15),
                                              ),
                                              child: Image.network(
                                                university['image'],
                                                height: 150,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Container(
                                                    height: 150,
                                                    color: Colors.grey[200],
                                                    child: Icon(
                                                      Icons.school,
                                                      size: 50,
                                                      color: Colors.grey[400],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    university['name'],
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .location_on_outlined,
                                                        size: 16,
                                                        color: Colors.grey[600],
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Expanded(
                                                        child: Text(
                                                          university[
                                                              'location'],
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Row(
                                                    children: [
                                                      Chip(
                                                        label: Text(
                                                          'Rank #${university['ranking']}',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12),
                                                        ),
                                                        backgroundColor:
                                                            Theme.of(context)
                                                                .primaryColor
                                                                .withOpacity(
                                                                    0.1),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Chip(
                                                        label: Text(
                                                          university['type'],
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12),
                                                        ),
                                                        backgroundColor:
                                                            Colors.grey[200],
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
    );
  }
}
