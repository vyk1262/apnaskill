// import 'package:flutter/material.dart';

// Widget buildInternshipTile(
//       BuildContext context, String internshipName, List<String> quizList) {
//     bool isUnlocked = userData?['internshipsList']?.any(
//             (internship) => internship['internshipName'] == internshipName) ??
//         false;

//     return Card(
//       color: Colors.black87,
//       elevation: 4,
//       margin: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 Icon(
//                   isUnlocked ? Icons.check_circle : Icons.lock,
//                   color: isUnlocked ? Colors.green : Colors.red,
//                   size: 40,
//                 ),
//                 const SizedBox(width: 12),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       internshipName,
//                       style: const TextStyle(
//                           fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       isUnlocked ? "Unlocked" : "Locked - Tap to Unlock",
//                       style: TextStyle(
//                           color: isUnlocked ? Colors.green : Colors.red),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     if (isUnlocked) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => QuizScreen(
//                             internshipName: internshipName,
//                             quizList: quizList,
//                           ),
//                         ),
//                       );
//                     } else {
//                       _showUnlockDialog(context, internshipName);
//                     }
//                   },
//                   child: Text(isUnlocked ? "Start Quiz" : "Unlock"),
//                 ),
//                 const SizedBox(width: 8),
//                 ElevatedButton(
//                   onPressed: () {
//                     _loadSyllabus(context, internshipName);
//                   },
//                   child: const Text("Syllabus"),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }