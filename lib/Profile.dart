import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skill_factorial/constants/colors.dart';
import 'package:skill_factorial/custom_app_bar.dart';
import 'package:intl/intl.dart';

import 'widgets/profile_page_widgets/form_widget.dart';
import 'widgets/profile_page_widgets/report_card.dart';

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
