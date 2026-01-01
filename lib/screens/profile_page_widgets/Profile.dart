import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skill_factorial/constants/colors.dart';
import 'package:skill_factorial/screens/common_widgets/custom_app_bar.dart';
import 'package:intl/intl.dart';

import 'form_widget.dart';
import 'report_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData;
  bool _isLoading = true;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _mobileNumberController;
  DateTime? _selectedDate;
  String? _selectedGender;
  List<String> genderOptions = ['Male', 'Female', 'Other', 'Prefer not to say'];

  TextEditingController _collegeController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  bool _isGeneratingProfId = false;

  // Calculate profile completion percentage dynamically
  double _calculateProfileCompletion() {
    if (userData == null) return 0.0;

    final trackableFields = [
      'email',
      'name',
      'mobileNumber',
      'dateOfBirth',
      'gender'
    ];
    int completedFields = 0;
    int totalFields = trackableFields.length;

    if (userData!['email']?.isNotEmpty ?? false)
      completedFields++; // Email usually always present
    if (_nameController.text.isNotEmpty) completedFields++;
    if (_mobileNumberController.text.isNotEmpty) completedFields++;
    if (_selectedDate != null) completedFields++;
    if (_selectedGender != null && _selectedGender!.isNotEmpty)
      completedFields++;

    return (completedFields / totalFields) * 100;
  }

  Future<void> _generateProfessorId() async {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Generate Professor ID'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _collegeController,
                decoration: const InputDecoration(
                  labelText: 'College Name *',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'City *',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _stateController,
                decoration: const InputDecoration(
                  labelText: 'State *',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _isGeneratingProfId
                  ? null
                  : () => _createProfessorId(setDialogState),
              child: _isGeneratingProfId
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Generate ID'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createProfessorId(StateSetter setDialogState) async {
    if (_collegeController.text.isEmpty ||
        _cityController.text.isEmpty ||
        _stateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    setDialogState(() => _isGeneratingProfId = true);

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('Not logged in');

      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

      // Get daily counter from Firestore
      final counterDoc = await FirebaseFirestore.instance
          .collection('professor_counters')
          .doc(today)
          .get();

      int counter = 1;
      if (counterDoc.exists) {
        counter = (counterDoc.data()?['count'] ?? 0) + 1;
      }

      final professorId = '$today-${counter.toString().padLeft(2, '0')}';

      // Update counter
      await FirebaseFirestore.instance
          .collection('professor_counters')
          .doc(today)
          .set({'count': counter, 'date': today}, SetOptions(merge: true));

      // Save to user profile
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'professor_id': professorId,
        'professor_college': _collegeController.text.trim(),
        'professor_city': _cityController.text.trim(),
        'professor_state': _stateController.text.trim(),
        'professor_created_at': Timestamp.now(),
      });

      // Refresh user data
      await _fetchUserData();

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Professor ID generated: $professorId ✓\nShare with your students!'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 4),
        ),
      );

      // Clear controllers
      _collegeController.clear();
      _cityController.clear();
      _stateController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setDialogState(() => _isGeneratingProfId = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _mobileNumberController = TextEditingController();
    _fetchUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileNumberController.dispose();
    _collegeController.dispose(); // NEW
    _cityController.dispose(); // NEW
    _stateController.dispose(); // NEW
    super.dispose();
  }

  Future<void> _fetchUserData() async {
    setState(() {
      _isLoading = true;
    });
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (snapshot.exists) {
          setState(() {
            userData = snapshot.data() as Map<String, dynamic>?;
            if (userData != null) {
              _nameController.text = userData!['name'] ?? '';
              _mobileNumberController.text = userData!['mobileNumber'] ?? '';
              if (userData!['dateOfBirth'] != null &&
                  userData!['dateOfBirth'].isNotEmpty) {
                try {
                  if (userData!['dateOfBirth'] is Timestamp) {
                    _selectedDate =
                        (userData!['dateOfBirth'] as Timestamp).toDate();
                  } else if (userData!['dateOfBirth'] is String) {
                    _selectedDate = DateFormat('yyyy-MM-dd')
                        .parse(userData!['dateOfBirth']);
                  }
                } catch (e) {
                  print('Error parsing dateOfBirth: $e');
                  _selectedDate = null;
                }
              }
              _selectedGender = userData!['gender'];
              // Ensure _selectedGender is one of the options or null
              if (_selectedGender != null &&
                  !genderOptions.contains(_selectedGender)) {
                // If a custom value was stored that isn't in options, you might want to:
                // 1. Add it to options temporarily: genderOptions.add(_selectedGender!);
                // 2. Set to null to force user selection: _selectedGender = null;
                // For now, we'll keep it as is if it's already stored.
              }
            }
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
          print('User document does not exist.');
          // Optionally, initialize userData with default values for a new user
          userData = {
            'email': user.email ?? 'N/A',
            'name': '',
            'mobileNumber': '',
            'dateOfBirth': null,
            'gender': null,
            'internshipsList': [],
          };
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        print('Error fetching user data: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching profile data: $e')),
        );
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print('No user logged in.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in.')),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _onGenderChanged(String? newValue) {
    setState(() {
      _selectedGender = newValue;
    });
  }

  Future<void> _saveUserData() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        try {
          Map<String, dynamic> updatedData = {
            'name': _nameController.text,
            'mobileNumber': _mobileNumberController.text,
            'email': userData!['email'],
            'dateOfBirth': _selectedDate != null
                ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                : null,
            'gender': _selectedGender,
          };

          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set(updatedData, SetOptions(merge: true));

          setState(() {
            userData!['name'] = _nameController.text;
            userData!['mobileNumber'] = _mobileNumberController.text;
            userData!['dateOfBirth'] = _selectedDate != null
                ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                : null;
            userData!['gender'] = _selectedGender;
            _isLoading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully!')),
          );
        } catch (e) {
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error updating profile: $e')),
          );
          print('Error saving user data: $e');
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        print('No user logged in to save data.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User not logged in.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Colors.grey[100], // Light gray background
      body: Center(
        // Center the entire body content
        child: _isLoading
            ? const CircularProgressIndicator()
            : userData != null
                ? SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(24.0),
                          child: FormWidget(
                            formKey: _formKey,
                            nameController: _nameController,
                            mobileNumberController: _mobileNumberController,
                            selectedDate: _selectedDate,
                            selectedGender: _selectedGender,
                            genderOptions: genderOptions,
                            onSelectDate: _selectDate,
                            onGenderChanged: _onGenderChanged,
                            onSave: _saveUserData,
                            isLoading: _isLoading,
                            profileCompletionPercentage:
                                _calculateProfileCompletion(),
                            userEmail: userData!['email'],
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (userData?['professor_id'] == null)
                          ElevatedButton(
                            onPressed: _generateProfessorId,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Generate Professor ID',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        if (userData?['professor_id'] != null)
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.green, width: 2),
                            ),
                            child: Column(
                              children: [
                                const Icon(Icons.badge,
                                    size: 48, color: Colors.green),
                                const SizedBox(height: 8),
                                Text(
                                  'Your Professor ID:',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      userData!['professor_id'],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    // copy id button
                                    IconButton(
                                      icon: const Icon(Icons.copy,
                                          color: Colors.green),
                                      onPressed: () {
                                        Clipboard.setData(ClipboardData(
                                            text: userData!['professor_id']));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content:
                                                  Text('Professor ID copied')),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${userData!['professor_college']}, ${userData!['professor_city']}, ${userData!['professor_state']}',
                                  style:
                                      TextStyle(color: Colors.green.shade800),
                                ),
                                const SizedBox(height: 12),
                              ],
                            ),
                          ),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                          child: ReportCardWidget(
                            internshipsList: userData!['internshipsList'],
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Text(
                      'User data not found. Please try again later.',
                      style: TextStyle(color: Colors.black87),
                      textAlign: TextAlign.center, // Center the text
                    ),
                  ),
      ),
    );
  }
}
