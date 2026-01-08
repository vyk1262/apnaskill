import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ApiService {
  ApiService._();
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<Map<String, dynamic>?> getUserData(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (!doc.exists) return null;
    return doc.data() as Map<String, dynamic>?;
  }

  static Future<void> updateUserData(String uid, Map<String, dynamic> data,
      {bool merge = true}) async {
    await _db.collection('users').doc(uid).set(data, SetOptions(merge: merge));
  }

  /// Generates a professor id for [uid] and saves professor metadata on the user.
  /// Returns the generated professor id.
  static Future<String> generateProfessorIdAndSave(
      String uid, String college, String city, String state) async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final counterRef = _db.collection('professor_counters').doc(today);
    final userRef = _db.collection('users').doc(uid);

    return await _db.runTransaction((tx) async {
      final counterSnap = await tx.get(counterRef);
      int counter = 1;
      if (counterSnap.exists) {
        counter = (counterSnap.data()?['count'] ?? 0) + 1;
      }

      final professorId = '$today-${counter.toString().padLeft(2, '0')}';

      tx.set(counterRef, {'count': counter, 'date': today});

      tx.set(
          userRef,
          {
            'professor_id': professorId,
            'professor_college': college,
            'professor_city': city,
            'professor_state': state,
            'professor_created_at': FieldValue.serverTimestamp(),
          },
          SetOptions(merge: true));

      return professorId;
    });
  }

  static Future<List<Map<String, dynamic>>> loadStudentsForProfessor(
      String professorId) async {
    final Map<String, List<Map<String, dynamic>>> result = {};

    // First try professor_assignments mapping
    final paSnapshot = await _db
        .collection('professor_assignments')
        .where('professor_id', isEqualTo: professorId)
        .get();

    if (paSnapshot.docs.isNotEmpty) {
      for (var doc in paSnapshot.docs) {
        final m = doc.data();
        final studentUid = m['student_uid'];
        if (studentUid == null) continue;
        final courseName = m['internshipName'] ?? 'Unknown Course';
        final studentDoc = await _db.collection('users').doc(studentUid).get();
        if (!studentDoc.exists) continue;
        final udata = studentDoc.data() as Map<String, dynamic>?;
        final studentInfo = {
          'uid': studentUid,
          'name': udata?['name'] ?? udata?['email'] ?? 'Unknown',
          'email': udata?['email'] ?? '',
          'mobileNumber': udata?['mobileNumber'] ?? '',
          'enrollmentType': m['enrollmentType'] ?? '',
          'course_tier': m['course_tier'] ?? '',
          'quizMarks': udata?['internshipsList'] != null
              ? _extractQuizMarksFromInternships(
                  udata!['internshipsList'], courseName)
              : [],
        };
        result.putIfAbsent(courseName, () => []).add(studentInfo);
      }
      // Flatten to list of maps for all courses
      return result.entries
          .expand((e) => e.value.map((v) => {...v, 'course': e.key}))
          .toList();
    }

    // Fallback: scan all users
    final allUsers = await _db.collection('users').get();
    for (var doc in allUsers.docs) {
      final udata = doc.data();
      if (udata['internshipsList'] == null) continue;
      final internships = udata['internshipsList'] as List;
      for (var entry in internships) {
        try {
          final item = Map<String, dynamic>.from(entry);
          if (item['professor_id'] != null &&
              item['professor_id'] == professorId) {
            final courseName = item['internshipName'] ?? 'Unknown Course';
            final studentInfo = {
              'uid': doc.id,
              'name': udata['name'] ?? udata['email'] ?? 'Unknown',
              'email': udata['email'] ?? '',
              'mobileNumber': udata['mobileNumber'] ?? '',
              'enrollmentType': item['enrollmentType'] ?? '',
              'course_tier': item['course_tier'] ?? '',
              'quizMarks': item['quizMarks'] ?? [],
            };
            result.putIfAbsent(courseName, () => []).add(studentInfo);
          }
        } catch (_) {}
      }
    }

    return result.entries
        .expand((e) => e.value.map((v) => {...v, 'course': e.key}))
        .toList();
  }

  static List<dynamic> _extractQuizMarksFromInternships(
      List<dynamic> internships, String internshipName) {
    for (var entry in internships) {
      try {
        final item = Map<String, dynamic>.from(entry);
        if (item['internshipName'] == internshipName) {
          return item['quizMarks'] ?? [];
        }
      } catch (_) {}
    }
    return [];
  }

  static Future<void> addProfessorAssignment(Map<String, dynamic> data) async {
    await _db.collection('professor_assignments').add(data);
  }

  /// Adds or updates a quiz entry for a user under a specific internship.
  static Future<void> addOrUpdateQuizMark(String userUid, String internshipName,
      Map<String, dynamic> quizEntry) async {
    final userRef = _db.collection('users').doc(userUid);
    await _db.runTransaction((tx) async {
      final snap = await tx.get(userRef);
      if (!snap.exists) throw Exception('User not found');
      final data = snap.data() as Map<String, dynamic>;
      final internships = List.from(data['internshipsList'] ?? []);

      // Ensure the quiz entry records when it was attempted.
      // Use client Timestamp for consistency; can be changed to server timestamp if desired.
      final Map<String, dynamic> enrichedEntry =
          Map<String, dynamic>.from(quizEntry);
      enrichedEntry['latestQuizAttemptedDate'] = Timestamp.now();

      final idx = internships.indexWhere(
          (it) => it is Map && it['internshipName'] == internshipName);
      if (idx == -1) {
        // Add new internship entry
        internships.add({
          'internshipName': internshipName,
          'course_tier': 'booster',
          'quizMarks': [enrichedEntry],
        });
      } else {
        final curr = Map<String, dynamic>.from(internships[idx]);
        final existing = List.from(curr['quizMarks'] ?? []);
        final qn = enrichedEntry['quizName'];
        final qIdx =
            existing.indexWhere((e) => e is Map && e['quizName'] == qn);
        if (qIdx != -1) {
          existing[qIdx] = enrichedEntry;
        } else {
          existing.add(enrichedEntry);
        }
        curr['quizMarks'] = existing;
        internships[idx] = curr;
      }

      tx.update(userRef, {'internshipsList': internships});
    });
  }

  static Future<void> unlockInternshipForUser(
      String userUid, Map<String, dynamic> internshipData) async {
    final userRef = _db.collection('users').doc(userUid);
    await userRef.set({
      'internshipsList': FieldValue.arrayUnion([internshipData])
    }, SetOptions(merge: true));
  }
}
