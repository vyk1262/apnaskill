// import 'package:flutter/material.dart';

// class InternshipInfoScreen extends StatelessWidget {
  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: GridView.builder(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2, // Two containers per row
//             crossAxisSpacing: 4.0,
//             mainAxisSpacing: 4.0,
//           ),
//           itemCount: internshipTexts.length,
//           itemBuilder: (context, index) {
//             return Container(
//               // padding: EdgeInsets.all(8.0),
//               width: MediaQuery.of(context).size.width / 8,
//               decoration: BoxDecoration(
//                 color: Colors.blue.shade50,
//                 borderRadius: BorderRadius.circular(10.0),
//                 border: Border.all(color: Colors.blue.shade200),
//               ),
//               child: Center(
//                 child: Text(
//                   internshipTexts[index],
//                   style: TextStyle(fontSize: 16.0, color: Colors.black87),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
