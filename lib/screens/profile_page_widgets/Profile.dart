import 'dart:convert';
import 'dart:io' show File, Directory;
import 'dart:html' as html;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import 'package:skill_factorial/constants/colors.dart';
import 'package:skill_factorial/screens/common_widgets/custom_app_bar.dart';
import 'package:skill_factorial/api_service.dart';

import 'form_widget.dart';
import 'report_card.dart'; // your FormWidget file

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // User profile data from Firestore
  Map<String, dynamic>? userData;

  // Text controllers
  late TextEditingController _nameController;
  late TextEditingController _mobileNumberController;

  // Professor info controllers (for dialog)
  final TextEditingController _collegeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();

  // Gender / DOB
  DateTime? _selectedDate;
  String? _selectedGender;
  final List<String> genderOptions = ['Male', 'Female', 'Other'];

  // Loading flags
  bool _isLoading = false;
  bool _isGeneratingProfId = false;

  // Professor / students
  bool _isProfessor = false;
  bool _loadingStudents = false;
  Map<String, List<Map<String, dynamic>>> _studentsByCourse = {};
  // Course -> list of quiz names loaded from assets/course_list.json
  Map<String, List<String>>? _courseQuizzes;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _mobileNumberController = TextEditingController();
    _loadCourseList();
    _fetchUserData();
  }

  Future<void> _loadCourseList() async {
    try {
      final jsonStr = await rootBundle.loadString('assets/course_list.json');
      final Map<String, dynamic> data =
          json.decode(jsonStr) as Map<String, dynamic>;
      final Map<String, List<String>> parsed = {};
      data.forEach((key, value) {
        if (value is List) {
          parsed[key] = value.map((e) => e.toString()).toList();
        }
      });
      if (mounted) setState(() => _courseQuizzes = parsed);
    } catch (e) {
      debugPrint('Error loading course_list.json: $e');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileNumberController.dispose();
    _collegeController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  Future<void> _fetchUserData() async {
    setState(() {
      _isLoading = true;
    });

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final data = await ApiService.getUserData(user.uid);
        setState(() {
          userData = data ??
              {
                'email': user.email ?? 'N/A',
                'name': '',
                'mobileNumber': '',
                'dateOfBirth': null,
                'gender': null,
                'internshipsList': [],
              };

          _nameController.text = userData!['name'] ?? '';
          _mobileNumberController.text = userData!['mobileNumber'] ?? '';

          if (userData!['dateOfBirth'] != null &&
              userData!['dateOfBirth'].toString().isNotEmpty) {
            try {
              if (userData!['dateOfBirth'] is Timestamp) {
                _selectedDate =
                    (userData!['dateOfBirth'] as Timestamp).toDate();
              } else if (userData!['dateOfBirth'] is String) {
                _selectedDate =
                    DateFormat('yyyy-MM-dd').parse(userData!['dateOfBirth']);
              }
            } catch (e) {
              debugPrint('Error parsing dateOfBirth: $e');
              _selectedDate = null;
            }
          }

          _selectedGender = userData!['gender'];

          // Professor detection
          _isProfessor = userData?['professor_id'] != null;
          if (_isProfessor) {
            _loadStudentsForProfessor();
          }

          // Ensure selectedGender is valid or null
          if (_selectedGender != null &&
              !genderOptions.contains(_selectedGender)) {
            // Keep as is for now
          }

          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        debugPrint('Error fetching user data: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching profile data: $e')),
        );
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      debugPrint('No user logged in.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in.')),
      );
    }
  }

  /// Loads students assigned to this professor, grouped by course.
  Future<void> _loadStudentsForProfessor() async {
    if (userData == null || userData!['professor_id'] == null) return;

    setState(() {
      _loadingStudents = true;
      _studentsByCourse = {};
    });

    final String myProfId = userData!['professor_id'];

    try {
      final rows = await ApiService.loadStudentsForProfessor(myProfId);
      // ApiService returns flattened list where each item has a 'course' key
      final Map<String, List<Map<String, dynamic>>> grouped = {};
      for (var r in rows) {
        final course = r['course'] ?? r['internshipName'] ?? 'Unknown Course';
        final studentInfo = Map<String, dynamic>.from(r);
        studentInfo.remove('course');
        grouped.putIfAbsent(course, () => []).add(studentInfo);
      }
      if (mounted) setState(() => _studentsByCourse = grouped);
    } catch (e) {
      debugPrint('Error loading students for professor: $e');
    } finally {
      if (mounted) setState(() => _loadingStudents = false);
    }
  }

  /// Generate CSV for a given course and save to a temp file.
  Future<void> _generateCsvForCourse(String courseName) async {
    if (userData == null || userData!['professor_id'] == null) return;

    final String myProfId = userData!['professor_id'];
    setState(() => _loadingStudents = true);

    try {
      final students =
          _studentsByCourse[courseName] ?? <Map<String, dynamic>>[];
      final StringBuffer csv = StringBuffer();

      // Determine quiz names for this course from loaded asset list.
      List<String> quizNames = _courseQuizzes?[courseName] ?? [];
      // If exact match not found, try case-insensitive/trimmed lookup
      if ((quizNames.isEmpty || quizNames.length == 0) &&
          _courseQuizzes != null) {
        final keyNorm = courseName.toString().toLowerCase().trim();
        for (final k in _courseQuizzes!.keys) {
          if (k.toLowerCase().trim() == keyNorm) {
            quizNames = _courseQuizzes![k]!;
            break;
          }
        }
      }

      // Fallback: if no quiz names found, infer from student data or default to Q1..Q30
      if (quizNames.isEmpty) {
        int maxLen = 0;
        for (final s in students) {
          final quizMarks = s['quizMarks'] ?? [];
          if (quizMarks is List && quizMarks.length > maxLen)
            maxLen = quizMarks.length;
        }
        if (maxLen == 0) maxLen = 30;
        quizNames = List.generate(maxLen, (i) => 'Q${i + 1}');
      }

      // Header
      final headers =
          <String>['Student Name', 'Student Email'] + quizNames + ['Total'];
      csv.writeln(headers.map(_escapeCsv).join(','));

      // Rows
      for (final s in students) {
        final row = <String>[];
        row.add(_escapeCsv(s['name']));
        row.add(_escapeCsv(s['email']));

        num total = 0;
        final rawQuizMarks = s['quizMarks'];

        // Build a map of quizName -> marks when quizMarks is list of maps
        final Map<String, num> marksByName = {};
        bool hasMapEntries = false;
        if (rawQuizMarks is List) {
          for (var entry in rawQuizMarks) {
            if (entry is Map) {
              hasMapEntries = true;
              final qnRaw =
                  entry['quizName'] ?? entry['quiz_name'] ?? entry['name'];
              final qn = qnRaw?.toString();
              final markVal = entry['marks'] ?? entry['score'] ?? entry['mark'];
              if (qn != null) {
                final parsed = num.tryParse(markVal?.toString() ?? '') ?? 0;
                marksByName[qn.toLowerCase().trim()] = parsed;
              }
            }
          }
        }

        for (int i = 0; i < quizNames.length; i++) {
          final qName = quizNames[i];
          final qNameNorm = qName.toLowerCase().trim();

          if (marksByName.containsKey(qNameNorm)) {
            final v = marksByName[qNameNorm]!;
            total += v;
            row.add(v.toString());
          } else if (!hasMapEntries &&
              rawQuizMarks is List &&
              i < rawQuizMarks.length) {
            // Only use index-based fallback when the quizMarks list is NOT map-based
            final vEntry = rawQuizMarks[i];
            if (vEntry is num ||
                (vEntry is String && num.tryParse(vEntry) != null)) {
              final v = num.tryParse(vEntry.toString()) ?? 0;
              total += v;
              row.add(v.toString());
            } else if (vEntry is Map &&
                (vEntry['marks'] != null || vEntry['score'] != null)) {
              final v = num.tryParse(
                      (vEntry['marks'] ?? vEntry['score']).toString()) ??
                  0;
              total += v;
              row.add(v.toString());
            } else {
              row.add('');
            }
          } else {
            row.add('');
          }
        }

        row.add(total.toString());
        csv.writeln(row.join(','));
      }

      final safeCourse = courseName.replaceAll(RegExp(r'[^A-Za-z0-9_]'), '_');
      final fileName = 'students_${myProfId}_$safeCourse.csv';

      if (kIsWeb) {
        _downloadCsvWeb(csv.toString(), fileName);
      } else {
        await _downloadCsvMobile(csv.toString(), fileName);
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('CSV error: $e')));
    } finally {
      setState(() => _loadingStudents = false);
    }
  }

  void _downloadCsvWeb(String csvContent, String fileName) {
    final bytes = utf8.encode(csvContent);
    final blob = html.Blob([bytes], 'text/csv');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', fileName)
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  Future<void> _downloadCsvMobile(String csvData, String fileName) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$fileName');
    await file.writeAsString(csvData);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('CSV saved to ${file.path}')),
    );
  }

  String _escapeCsv(String? value) {
    if (value == null) return '';
    if (value.contains(',') || value.contains('"') || value.contains('\n')) {
      final escaped = value.replaceAll('"', '""');
      return '"$escaped"';
    }
    return value;
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
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && userData != null) {
      try {
        final updatedData = <String, dynamic>{
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
        debugPrint('Error saving user data: $e');
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      debugPrint('No user logged in to save data.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in.')),
      );
    }
  }

  double _calculateProfileCompletion() {
    if (userData == null) return 0;

    int total = 4;
    int filled = 0;

    if ((userData!['name'] ?? '').toString().isNotEmpty) filled++;
    if ((userData!['mobileNumber'] ?? '').toString().isNotEmpty) filled++;
    if (userData!['dateOfBirth'] != null) filled++;
    if (userData!['gender'] != null &&
        userData!['gender'].toString().isNotEmpty) {
      filled++;
    }

    return filled / total;
  }

  void _generateProfessorId() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
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
            );
          },
        );
      },
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

      final professorId = await ApiService.generateProfessorIdAndSave(
          user.uid,
          _collegeController.text.trim(),
          _cityController.text.trim(),
          _stateController.text.trim());

      // Refresh
      await _fetchUserData();
      await _loadStudentsForProfessor();

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Professor ID generated: $professorId ✓\nShare with your students!',
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 4),
        ),
      );

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Colors.grey[100],
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : userData != null
                ? SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        // Profile form card
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

                        // Generate Professor ID button (if not yet a professor)
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

                        // Professor badge and details
                        if (userData?['professor_id'] != null)
                          Container(
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.only(top: 8),
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
                                  mainAxisSize: MainAxisSize.min,
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
                                                Text('Professor ID copied'),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${userData!['professor_college']}, '
                                  '${userData!['professor_city']}, '
                                  '${userData!['professor_state']}',
                                  style:
                                      TextStyle(color: Colors.green.shade800),
                                ),
                                const SizedBox(height: 12),
                              ],
                            ),
                          ),

                        const SizedBox(height: 16),

                        // Report card / internships summary
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
                            internshipsList: userData!['internshipsList'] ?? [],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Students assigned (for professors)
                        if (_isProfessor)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Students Assigned',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                _loadingStudents
                                    ? const Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                    : _studentsByCourse.isEmpty
                                        ? const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 12.0),
                                            child: Text(
                                              'No students assigned to your Professor ID yet.',
                                            ),
                                          )
                                        : Column(
                                            children: _studentsByCourse.entries
                                                .map(
                                                  (entry) => Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 6.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            '${entry.key} (${entry.value.length})',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        ElevatedButton.icon(
                                                          icon: const Icon(
                                                              Icons.download),
                                                          label: const Text(
                                                              'Download CSV'),
                                                          onPressed: () =>
                                                              _generateCsvForCourse(
                                                                  entry.key),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                              ],
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
                      textAlign: TextAlign.center,
                    ),
                  ),
      ),
    );
  }
}
