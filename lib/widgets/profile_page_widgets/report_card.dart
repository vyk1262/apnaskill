import 'package:flutter/material.dart';
import 'package:skill_factorial/constants/colors.dart';

class ReportCardWidget extends StatelessWidget {
  final List<dynamic>? internshipsList;

  const ReportCardWidget({
    Key? key,
    this.internshipsList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 850;

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
                mainAxisAlignment: MainAxisAlignment.center,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                      color: AppColors.secondaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        internship['internshipName'] ?? 'N/A',
                        textAlign: TextAlign.center,
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: List.generate(
                            (internship['quizMarks'] as List).length,
                            (quizIndex) {
                              final quiz = internship['quizMarks'][quizIndex];

                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isMobile ? 6 : 10,
                                  vertical: isMobile ? 2 : 4,
                                ),
                                margin: const EdgeInsets.symmetric(vertical: 2),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Row(
                                  // This Row now centers its contents as a unit and takes minimal space
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // CONDITIONAL WIDGET HERE:
                                    if (isMobile)
                                      Expanded(
                                        // On mobile, allow text to expand and truncate
                                        child: Text(
                                          quiz['quizName']
                                              .toString()
                                              .replaceAll('_', ' '),
                                          style: TextStyle(
                                              color: Colors.grey[700]),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      )
                                    else
                                      Text(
                                        // On laptop, text takes natural width
                                        quiz['quizName']
                                            .toString()
                                            .replaceAll('_', ' '),
                                        style:
                                            TextStyle(color: Colors.grey[700]),
                                        overflow: TextOverflow
                                            .ellipsis, // Still truncate if name is very long
                                        maxLines: 1,
                                      ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Score: ${quiz['marks']}/${quiz['total_questions']}',
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.w500),
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
