import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skill_factorial/custom_app_bar.dart';
import 'package:intl/intl.dart'; // For date formatting

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
  DateTime? _selectedDate;
  String? _selectedGender;
  List<String> genderOptions = ['Male', 'Female', 'Other', 'Prefer not to say'];

  // Calculate profile completion percentage dynamically
  double _calculateProfileCompletion() {
    if (userData == null) return 0.0;

    // Define fields to track for completion, excluding system or internal fields
    final trackableFields = ['email', 'name', 'dateOfBirth', 'gender'];
    int completedFields = 0;
    int totalFields = trackableFields.length;

    for (String field in trackableFields) {
      if (field == 'name') {
        if (userData![field]?.isNotEmpty ?? false) completedFields++;
      } else if (userData![field] != null) {
        completedFields++;
      }
    }

    return (completedFields / totalFields) * 100;
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _fetchUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
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
              if (userData!['dateOfBirth'] != null &&
                  userData!['dateOfBirth'].isNotEmpty) {
                try {
                  // Assuming dateOfBirth is stored as a String in 'yyyy-MM-dd' format or as a Timestamp
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
              if (_selectedGender != null &&
                  !genderOptions.contains(_selectedGender)) {
                // If the stored gender is not in predefined options, add it or handle as needed
                // For simplicity, we'll just allow it if it's a custom value already stored.
                // Or, reset to null if you want to force selection from options:
                // _selectedGender = null;
              }
            }
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
          // Handle case where user document doesn't exist
          print('User document does not exist.');
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        print('Error fetching user data: $e');
        // Handle error fetching data
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      // Handle case where user is null (should not happen if screen is protected)
      print('No user logged in.');
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
            'email': userData![
                'email'], // Email is not editable, but good to keep it consistent
            'dateOfBirth': _selectedDate != null
                ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                : null,
            'gender': _selectedGender,
          };

          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set(
                  updatedData,
                  SetOptions(
                      merge: true)); // Use set with merge to update or create

          setState(() {
            userData!['name'] = _nameController.text;
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
        child: _isLoading
            ? const CircularProgressIndicator()
            : userData != null
                ? SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
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
                      padding: const EdgeInsets.all(24.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'My Profile',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            // Profile completion percentage
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Profile Completion',
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 14),
                                      ),
                                      Text(
                                        '${_calculateProfileCompletion()}%',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  LinearProgressIndicator(
                                    value: _calculateProfileCompletion() / 100,
                                    backgroundColor: Colors.grey[200],
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Theme.of(context).primaryColor),
                                    minHeight: 8,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Email (Non-editable)
                            Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Email',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                                color: Colors.grey[700])),
                                    const SizedBox(height: 4),
                                    Text(userData!['email'] ?? 'N/A',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Name
                            TextFormField(
                              controller: _nameController,
                              style: TextStyle(color: Colors.black87),
                              decoration: InputDecoration(
                                labelText: 'Name',
                                labelStyle: TextStyle(color: Colors.grey[700]),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      BorderSide(color: Colors.grey[300]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                ),
                                filled: true,
                                fillColor: Colors.grey[50],
                                prefixIcon: Icon(Icons.person_outline,
                                    color: Colors.grey[600]),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),

                            // Date of Birth
                            InkWell(
                              onTap: () => _selectDate(context),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: 'Date of Birth',
                                  labelStyle:
                                      TextStyle(color: Colors.grey[700]),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        BorderSide(color: Colors.grey[300]!),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[50],
                                  prefixIcon: Icon(
                                      Icons.calendar_today_outlined,
                                      color: Colors.grey[600]),
                                ),
                                child: Text(
                                  _selectedDate != null
                                      ? DateFormat('dd MMMM yyyy')
                                          .format(_selectedDate!)
                                      : 'Select your date of birth',
                                  style: TextStyle(
                                    color: _selectedDate == null
                                        ? Colors.grey[600]
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.color,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Gender
                            DropdownButtonFormField<String>(
                              value: _selectedGender,
                              style: TextStyle(color: Colors.black87),
                              decoration: InputDecoration(
                                labelText: 'Gender',
                                labelStyle: TextStyle(color: Colors.grey[700]),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      BorderSide(color: Colors.grey[300]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                ),
                                filled: true,
                                fillColor: Colors.grey[50],
                                prefixIcon: Icon(Icons.wc_outlined,
                                    color: Colors.grey[600]),
                              ),
                              items: genderOptions.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedGender = newValue;
                                });
                              },
                              // validator: (value) => value == null ? 'Please select your gender' : null, // Optional validation
                            ),
                            const SizedBox(height: 32),

                            // Save Button
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                backgroundColor: Theme.of(context).primaryColor,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: _isLoading ? null : _saveUserData,
                              child: _isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.white)))
                                  : const Text('Save Changes',
                                      style: TextStyle(fontSize: 16)),
                            ),
                          ],
                        ),
                      ),
                    ))
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
                    ),
                  ),
      ),
    );
  }
}
