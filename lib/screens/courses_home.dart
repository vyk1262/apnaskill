import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_factorial/constants/colors.dart'; // Assuming AppColors.primaryColor exists here
import 'package:skill_factorial/screens/custom_search_bar.dart';
import 'package:skill_factorial/widgets/cached_network_image_widget.dart'; // Keep if used elsewhere or remove if not

import '../constants/image_urls.dart'; // Keep if used elsewhere or remove if not
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
  bool _showMyCourses =
      false; // State to toggle between 'My Courses' and 'All Courses'

  @override
  void initState() {
    super.initState();
    _fetchAndLoadData(); // Call a new method to handle data loading and initial filtering
    _searchController
        .addListener(_applyFilters); // Use the unified filter method
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Fetches user data and loads internship topics, then applies initial filters.
  Future<void> _fetchAndLoadData() async {
    // Fetch user data first
    await _fetchUserData();
    // Load internship topics
    await _loadInternshipAndTopics();
    // Apply filters once all data is loaded
    _applyFilters();
  }

  /// Fetches the current user's data from Firestore.
  /// Updates `userData` and `user` state.
  Future<void> _fetchUserData() async {
    user = FirebaseAuth.instance.currentUser; // Refresh user instance
    if (user != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid) // Use user!.uid as user is guaranteed not null here
          .get();

      setState(() {
        userData = snapshot.data() as Map<String, dynamic>?;
      });
    } else {
      setState(() {
        userData = null; // Clear user data if not logged in
      });
    }
  }

  /// Loads internship names and quiz topics from the 'assets/course_list.json' file.
  /// Populates `allInternshipNames` and `quizTopics`.
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
            // Log error if the value is not a list
            print(
                "Error: Value for key '$key' is not a List in course_list.json");
            return MapEntry(key, <String>[]);
          }
        });
        // Note: filteredInternshipNames is not directly initialized here,
        // it will be set by _applyFilters after this method completes.
      });
    } catch (e) {
      print('Error loading data: $e');
      if (mounted) {
        // Check if the widget is still in the widget tree before showing SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error loading data. Please try again.'),
          ),
        );
      }
    }
  }

  /// Applies both the search filter and the 'My Courses'/'All Courses' filter.
  /// Updates `filteredInternshipNames` based on the current state.
  void _applyFilters() {
    setState(() {
      List<String> coursesToProcess = [];

      if (_showMyCourses) {
        // If 'My Courses' is selected, filter based on unlocked internships
        if (userData != null && userData!['internshipsList'] != null) {
          coursesToProcess = (userData!['internshipsList'] as List)
              .map((item) => item['internshipName'] as String)
              .toList();
        } else {
          coursesToProcess = []; // No unlocked courses or user data
        }
      } else {
        // If 'All Courses' is selected, use all available internships
        coursesToProcess = List.from(allInternshipNames);
      }

      // Apply the search filter to the `coursesToProcess` list
      filteredInternshipNames = coursesToProcess
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
                      // Adjust padding to avoid overlap with search bar (top) and FABs (bottom)
                      padding: EdgeInsets.only(
                        top: _isSearching
                            ? 80.0
                            : 16.0, // Top padding when search bar is visible
                        bottom: _isSearching
                            ? 16.0
                            : 140.0, // Increased bottom padding for stacked FABs
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

          // 1. Floating Action Button for Search (Bottom Right)
          // Positioned at the bottom right, with increased background color consistency
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: AnimatedOpacity(
              opacity: _isSearching ? 0.0 : 1.0, // Fade out when searching
              duration: const Duration(milliseconds: 300),
              child: IgnorePointer(
                // Prevent clicks when faded out
                ignoring: _isSearching,
                child: FloatingActionButton.extended(
                  heroTag: 'search_fab', // Unique hero tag for the search FAB
                  backgroundColor: Colors.white, // Changed for consistency
                  onPressed: () {
                    setState(() {
                      _isSearching = true;
                    });
                  },
                  label: const Text(
                    "Search",
                    style: TextStyle(color: Colors.black),
                  ),
                  icon: const Icon(Icons.search, size: 24, color: Colors.black),
                ),
              ),
            ),
          ),

          // 2. Floating Action Button for 'My Courses' / 'All Courses' (Above Search Button)
          // Positioned above the search button, also on the right side
          Positioned(
            bottom:
                78.0, // 16.0 (search button bottom) + 40 (mini FAB height) + 22 (spacing)
            right: 16.0, // Align to the right, same as search button
            child: AnimatedOpacity(
              opacity: _isSearching ? 0.0 : 1.0, // Fade out when searching
              duration: const Duration(milliseconds: 300),
              child: IgnorePointer(
                // Prevent clicks when faded out
                ignoring: _isSearching,
                child: FloatingActionButton.extended(
                  heroTag: 'toggle_courses_fab', // Unique hero tag for this FAB
                  backgroundColor:
                      Colors.white, // Use a distinct color for this button
                  onPressed: () {
                    setState(() {
                      _showMyCourses = !_showMyCourses; // Toggle the state
                      _applyFilters(); // Re-apply filters based on the new state
                    });
                  },
                  label: Text(
                    _showMyCourses ? 'My Courses' : 'All Courses',
                    style: const TextStyle(color: Colors.black),
                  ),
                  icon: Icon(
                    _showMyCourses
                        ? Icons.book
                        : Icons.library_books, // Change icon based on state
                    size: 24,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),

          // 3. Expanded Search Bar (Top Center)
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
                          _applyFilters(); // Re-filter to show all based on current _showMyCourses state
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

  /// Builds an individual internship card for the grid.
  Widget buildInternshipCard(
      BuildContext context, String internshipName, List<String> quizList) {
    // Check if the current internship is unlocked for the user
    bool isUnlocked = userData?['internshipsList']?.any(
            (internship) => internship['internshipName'] == internshipName) ??
        false;

    // This part is commented out, but kept for reference if image logic is reintroduced.
    // String imageUrl = ImageUrls.courseImages[internshipName] ??
    //     'https://i.ibb.co/W4KbgWSq/sfcmp.png';

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(
          color: isUnlocked
              ? Colors.green
              : Colors.amber[700] ??
                  Colors.black, // Border color based on unlocked status
          width: 2.0,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15.0),
        onTap: () {
          // Redirect to login if user is not authenticated
          if (user == null) {
            GoRouter.of(context).go('/login');
            return;
          }
          // Navigate to QuizScreen if unlocked, otherwise show unlock dialog
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: AppColors
                          .gradientPrimary, // Assuming AppColors.gradientPrimary exists
                    ),
                    child: Center(
                      child: Text(
                        // Format internship name to capitalize first letter of each word
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
                  if (!isUnlocked) // Show price only if not unlocked
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
                    isUnlocked
                        ? "Unlocked"
                        : "Free", // Display 'Unlocked' or 'Free'
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
                        // Redirect to login if user is not authenticated
                        if (user == null) {
                          GoRouter.of(context).go('/login');
                          return;
                        }
                        // Navigate to QuizScreen if unlocked, otherwise show unlock dialog
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
                          isUnlocked
                              ? Icons.play_arrow
                              : Icons
                                  .lock_open, // Icon changes based on unlocked status
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

  /// Shows a dialog for unlocking an internship.
  /// Collects UPI transaction ID and mobile number.
  void _showUnlockDialog(BuildContext context, String internshipName) {
    final upiController = TextEditingController();
    final mobileNumberController = TextEditingController(
        text: userData?['mobileNumber'] ?? ''); // Pre-fill if available
    final _formKey = GlobalKey<FormState>(); // Key for form validation

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Unlock - $internshipName"),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // Make column only take necessary space
            children: [
              const Text("Enter Code below: FREE"), // Instruction for the code
              TextFormField(
                controller: upiController,
                decoration: const InputDecoration(hintText: 'FREE'),
                validator: (value) {
                  if (value == null || value.isEmpty || value != 'FREE') {
                    return 'Code is required and must be FREE'; // Validation for the code
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              const Text(
                  "Enter Mobile Number"), // Instruction for mobile number
              TextFormField(
                controller: mobileNumberController,
                decoration: const InputDecoration(hintText: 'Mobile Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mobile Number is required'; // Validation for mobile number
                  }
                  if (value.length != 10) {
                    return 'Enter a 10-digit mobile number'; // Length validation
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
                // Validate form before submitting
                await _unlockInternshipAndStoreData(internshipName,
                    upiController.text, mobileNumberController.text);
                if (mounted)
                  Navigator.of(context)
                      .pop(); // Pop dialog if widget is still mounted
              }
            },
            child: const Text("Submit"),
          ),
          TextButton(
            onPressed: () =>
                Navigator.of(context).pop(), // Close dialog on cancel
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  /// Unlocks an internship for the current user and stores the data in Firestore.
  /// Refreshes user data after the update.
  Future<void> _unlockInternshipAndStoreData(
      String internshipName, String upiTraId, String mobileNumber) async {
    user = FirebaseAuth.instance.currentUser; // Get current user
    if (user != null) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .set({
          // Use set with merge: true to avoid overwriting other fields
          'internshipsList': FieldValue.arrayUnion([
            {
              'internshipName': internshipName,
              'quizMarks': [], // Initialize with empty marks
              'upiTraId': upiTraId,
            }
          ]),
          'mobileNumber': mobileNumber // Update mobile number
        }, SetOptions(merge: true)); // Merge with existing document
        _fetchUserData(); // Refresh user data to update the UI
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$internshipName unlocked successfully!')),
          );
        }
      } catch (e) {
        print('Error unlocking internship: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content:
                    Text('Failed to unlock internship. Please try again.')),
          );
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please log in to unlock courses.')),
        );
      }
    }
  }

  /// Shows a dialog with the topics for a given internship.
  void _loadTopics(BuildContext context, String internshipName) {
    List<String>? topics = quizTopics[internshipName];
    if (topics != null && topics.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('$internshipName Topics'),
          content: SizedBox(
            width: double.maxFinite, // Allow content to take maximum width
            child: ListView.builder(
              shrinkWrap:
                  true, // Use shrinkWrap to prevent ListView from taking infinite height
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
              onPressed: () => Navigator.pop(context), // Close dialog
              child: const Text('Close'),
            ),
          ],
        ),
      );
    } else {
      // Show SnackBar if no topics are found
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Topics not found for $internshipName.')),
      );
    }
  }
}
