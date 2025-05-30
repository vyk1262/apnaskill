import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_factorial/constants/colors.dart';
import 'package:skill_factorial/screens/custom_search_bar.dart';
import 'package:skill_factorial/widgets/cached_network_image_widget.dart';

import '../constants/image_urls.dart';
import '../custom_app_bar.dart';
import 'quiz_screen.dart';

class QuizListHome extends StatefulWidget {
  const QuizListHome({Key? key}) : super(key: key);

  @override
  State<QuizListHome> createState() => _QuizListHomeState();
}

class _QuizListHomeState extends State<QuizListHome> {
  Map<String, dynamic>? userData;
  User? user = FirebaseAuth.instance.currentUser;
  Map<String, List<String>> quizTopics = {};
  List<String> allInternshipNames = [];
  List<String> filteredInternshipNames = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    _loadInternshipAndTopics();
    _searchController.addListener(_filterInternships);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        userData = snapshot.data() as Map<String, dynamic>?;
      });
    }
  }

  Future<void> _loadInternshipAndTopics() async {
    try {
      final String data =
          await rootBundle.loadString('assets/course_list.json');
      final Map<String, dynamic> decodedData = jsonDecode(data);
      setState(() {
        allInternshipNames = decodedData.keys.toList();
        quizTopics = decodedData.map((key, value) {
          if (value is List) {
            return MapEntry(key, value.cast<String>());
          } else {
            print(
                "Error: Value for key '$key' is not a List in course_list.json");
            return MapEntry(key, <String>[]);
          }
        });
        filteredInternshipNames.addAll(allInternshipNames);
      });
    } catch (e) {
      print('Error loading data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error loading data. Please try again.'),
        ),
      );
    }
  }

  void _filterInternships() {
    setState(() {
      filteredInternshipNames = allInternshipNames
          .where((internship) => internship
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Stack(
        children: [
          Column(
            children: [
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
                      // Add conditional padding to avoid overlap with the search bar
                      padding: EdgeInsets.only(
                        top: _isSearching
                            ? 80.0
                            : 16.0, // Adjust top padding when search bar is visible
                        bottom: _isSearching
                            ? 16.0
                            : 80.0, // Adjust bottom padding when button is visible
                        left: 16.0,
                        right: 16.0,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: filteredInternshipNames.length,
                      itemBuilder: (context, index) {
                        final internshipName = filteredInternshipNames[index];
                        final quizList = quizTopics[internshipName] ?? [];
                        return buildInternshipCard(
                            context, internshipName, quizList);
                      },
                    );
                  },
                ),
              ),
            ],
          ),

          // 1. Floating Action Button (Bottom Right)
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: AnimatedOpacity(
              opacity: _isSearching ? 0.0 : 1.0, // Fade out when searching
              duration: const Duration(milliseconds: 300),
              child: IgnorePointer(
                // Prevent clicks when faded out
                ignoring: _isSearching,
                child: FloatingActionButton(
                  backgroundColor: Colors.black,
                  onPressed: () {
                    setState(() {
                      _isSearching = true;
                    });
                  },
                  mini: true,
                  child:
                      const Icon(Icons.search, size: 24, color: Colors.white),
                ),
              ),
            ),
          ),

          // 2. Expanded Search Bar (Top Center)
          Positioned(
            top: 16.0, // Position at the top
            left: 0, // Extend across full width to allow centering
            right: 0,
            child: AnimatedOpacity(
              opacity: _isSearching ? 1.0 : 0.0, // Fade in when searching
              duration: const Duration(milliseconds: 300),
              child: IgnorePointer(
                // Prevent clicks when faded out
                ignoring: !_isSearching,
                child: Align(
                  // Align the search bar to the center
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width *
                        0.7, // Desired width when expanded
                    child: CustomSearchBar(
                      controller: _searchController,
                      hintText: 'Search Courses...',
                      onClose: () {
                        setState(() {
                          _isSearching = false;
                          _searchController.clear(); // Clear text when closing
                          _filterInternships(); // Re-filter to show all when cleared
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInternshipCard(
      BuildContext context, String internshipName, List<String> quizList) {
    bool isUnlocked = userData?['internshipsList']?.any(
            (internship) => internship['internshipName'] == internshipName) ??
        false;

    String imageUrl = ImageUrls.courseImages[internshipName] ??
        'https://i.ibb.co/W4KbgWSq/sfcmp.png';

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(
          color: isUnlocked ? Colors.green : Colors.amber[700] ?? Colors.black,
          width: 2.0,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15.0),
        onTap: () {
          if (user == null) {
            GoRouter.of(context).go('/login');
            return;
          }
          if (isUnlocked) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuizScreen(
                  internshipName: internshipName,
                  quizList: quizList,
                ),
              ),
            );
          } else {
            _showUnlockDialog(context, internshipName);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                // child: ClipRRect(
                //   borderRadius: BorderRadius.circular(10.0),
                //   child: CachedNetworkImageWidget(
                //     imageUrl: imageUrl,
                //     width: double.infinity,
                //     fit: BoxFit.cover,
                //     errorWidget: const Icon(Icons.broken_image),
                //   ),
                // ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: AppColors.gradientPrimary,
                    ),
                    child: Center(
                      child: Text(
                        internshipName.split(' ').map((word) {
                          if (word.isEmpty) {
                            return '';
                          }
                          return word[0].toUpperCase() +
                              word.substring(1).toLowerCase();
                        }).join(' '),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                internshipName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!isUnlocked)
                    const Text(
                      '₹99/-',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  const SizedBox(width: 5),
                  Text(
                    isUnlocked ? "Unlocked" : "Free",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isUnlocked ? Colors.green : Colors.amber[700],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly, // Distribute space evenly
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        _loadTopics(context, internshipName);
                      },
                      icon: const Icon(Icons.menu_book, size: 18),
                      label: const Text("Topics"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.primary,
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10), // Space between buttons
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (user == null) {
                          GoRouter.of(context).go('/login');
                          return;
                        }
                        if (isUnlocked) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizScreen(
                                internshipName: internshipName,
                                quizList: quizList,
                              ),
                            ),
                          );
                        } else {
                          _showUnlockDialog(context, internshipName);
                        }
                      },
                      icon: Icon(
                          isUnlocked ? Icons.play_arrow : Icons.lock_open,
                          size: 18),
                      label: Text(isUnlocked ? "Start Quiz" : "Unlock"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isUnlocked
                            ? Colors.green
                            : Theme.of(context).colorScheme.secondary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showUnlockDialog(BuildContext context, String internshipName) {
    final upiController = TextEditingController();
    final mobileNumberController =
        TextEditingController(text: userData?['mobileNumber'] ?? '');
    final _formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Unlock - $internshipName"),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // const Text(
              //   'Scan the QR code below to pay',
              //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              // ),
              // const SizedBox(height: 8),
              // Image.asset(
              //   'assets/student_home/qrcode.jpg',
              //   width: 100,
              //   height: 100,
              //   fit: BoxFit.cover,
              // ),
              // const SizedBox(height: 8),
              const Text("Enter Code below: FREE"), //Enter UPI Transaction ID
              TextFormField(
                controller: upiController,
                decoration: const InputDecoration(hintText: 'FREE'),
                validator: (value) {
                  if (value == null || value.isEmpty || value != 'FREE') {
                    return 'Code is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              const Text("Enter Mobile Number"),
              TextFormField(
                controller: mobileNumberController,
                decoration: const InputDecoration(hintText: 'Mobile Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mobile Number is required';
                  }
                  if (value.length != 10) {
                    return 'Enter a 10-digit mobile number';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await _unlockInternshipAndStoreData(internshipName,
                    upiController.text, mobileNumberController.text);
                if (mounted) Navigator.of(context).pop();
              }
            },
            child: const Text("Submit"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  Future<void> _unlockInternshipAndStoreData(
      String internshipName, String upiTraId, String mobileNumber) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'internshipsList': FieldValue.arrayUnion([
          {
            'internshipName': internshipName,
            'quizMarks': [],
            'upiTraId': upiTraId,
          }
        ]),
        'mobileNumber': mobileNumber
      });
      _fetchUserData(); // Refresh user data to reflect the new unlocked internship
    }
  }

  void _loadTopics(BuildContext context, String internshipName) {
    List<String>? topics = quizTopics[internshipName];
    if (topics != null && topics.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('$internshipName Topics'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: topics.length,
              itemBuilder: (context, index) => Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Text('${index + 1}',
                        style: const TextStyle(color: Colors.white)),
                  ),
                  title: Text(
                    topics[index],
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Topics not found for $internshipName.')),
      );
    }
  }
}
