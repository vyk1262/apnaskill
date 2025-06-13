import 'package:flutter/material.dart';

class ReportCardWidget extends StatelessWidget {
  final List<dynamic>? internshipsList;

  const ReportCardWidget({
    Key? key,
    this.internshipsList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (internshipsList == null || internshipsList!.isEmpty) {
      return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center the icon and title
                children: [
                  Icon(Icons.school, color: Theme.of(context).primaryColor),
                  const SizedBox(width: 8),
                  Text('Course Report',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'No course or internship data available yet.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Center contents of the card
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center the icon and title
              children: [
                Icon(Icons.school, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                Text('Course Report',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            ...List.generate(
              internshipsList!.length,
              (index) {
                final internship = internshipsList![index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        internship['internshipName'] ?? 'N/A',
                        textAlign: TextAlign.center, // Center internship name
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                      ),
                      if (internship['quizMarks'] != null &&
                          (internship['quizMarks'] as List).isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Quiz Results:',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 4),
                        // Improved alignment for quiz marks
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: List.generate(
                            (internship['quizMarks'] as List).length,
                            (quizIndex) {
                              final quiz = internship['quizMarks'][quizIndex];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      quiz['quizName']
                                          .toString()
                                          .replaceAll('_', ' '),
                                      style: TextStyle(color: Colors.grey[700]),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                        width:
                                            8), // Spacing between text and score box
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Text(
                                        'Score: ${quiz['marks']}',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ] else ...[
                        const SizedBox(height: 8),
                        Text(
                          'No quiz data for this internship.',
                          style: TextStyle(color: Colors.grey[500]),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
