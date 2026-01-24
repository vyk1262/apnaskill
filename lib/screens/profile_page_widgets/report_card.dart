import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skill_factorial/constants/colors.dart';

class ReportCardWidget extends StatefulWidget {
  final List<dynamic>? internshipsList;

  const ReportCardWidget({
    Key? key,
    this.internshipsList,
  }) : super(key: key);

  @override
  State<ReportCardWidget> createState() => _ReportCardWidgetState();
}

class _ReportCardWidgetState extends State<ReportCardWidget> {
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 850;

    if (widget.internshipsList == null || widget.internshipsList!.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 30,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          children: [
            FaIcon(
              Icons.assignment_outlined,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'Course Report',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'No course or internship data available yet.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Complete courses to see your progress here',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              FaIcon(
                Icons.assignment_turned_in_outlined,
                color: const Color(0xFF4A90E2),
                size: 28,
              ),
              const SizedBox(width: 12),
              Text(
                'Course Report',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              Text(
                '${widget.internshipsList!.length} Course${widget.internshipsList!.length > 1 ? 's' : ''}',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Courses List
          ...List.generate(
            widget.internshipsList!.length,
            (index) {
              final internship = widget.internshipsList![index];
              final isExpanded = _expandedIndex == index;
              final totalQuizzes =
                  (internship['quizMarks'] as List?)?.length ?? 0;
              final totalMarks = _calculateTotalMarks(internship);
              final totalQuestions = _calculateTotalQuestions(internship);
              final avgPercentage = totalQuizzes > 0
                  ? (totalMarks / totalQuestions * 100).toInt()
                  : 0;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _expandedIndex = isExpanded ? null : index;
                  });
                },
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(isExpanded ? 0.12 : 0.08),
                          blurRadius: isExpanded ? 20 : 12,
                          offset: Offset(0, isExpanded ? 6 : 3),
                        ),
                      ],
                      border: Border.all(
                        color: isExpanded
                            ? const Color(0xFF4A90E2).withOpacity(0.3)
                            : Colors.grey.shade200,
                        width: isExpanded ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        // Course Header (Always visible)
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFF4A90E2).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: FaIcon(
                                  Icons.school_outlined,
                                  color: const Color(0xFF4A90E2),
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      internship['internshipName'] ??
                                          'Unnamed Course',
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black87,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '$totalQuizzes Quiz${totalQuizzes != 1 ? 'es' : ''} • Avg: $avgPercentage%',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Expand/Collapse Icon
                              AnimatedRotation(
                                duration: const Duration(milliseconds: 300),
                                turns: isExpanded ? 0.5 : 0,
                                child: FaIcon(
                                  isExpanded
                                      ? Icons.expand_less
                                      : Icons.expand_more,
                                  color: isExpanded
                                      ? const Color(0xFF4A90E2)
                                      : Colors.grey.shade500,
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Expandable Quiz Details
                        AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: isExpanded
                              ? Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 20),
                                  child: Column(
                                    children: [
                                      const Divider(height: 1),
                                      const SizedBox(height: 16),
                                      Text(
                                        'Quiz Results',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      ...List.generate(
                                        (internship['quizMarks'] as List)
                                            .length,
                                        (quizIndex) {
                                          final quiz = internship['quizMarks']
                                              [quizIndex];
                                          final quizName = quiz['quizName']
                                                  ?.toString()
                                                  .replaceAll('_', ' ') ??
                                              'Quiz ${quizIndex + 1}';
                                          final marks = quiz['marks'] ?? 0;
                                          final total =
                                              quiz['total_questions'] ?? 10;
                                          final percentage =
                                              (marks / total * 100).toInt();

                                          return Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.all(16),
                                            margin: const EdgeInsets.only(
                                                bottom: 12),
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade50,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  color: Colors.grey.shade200),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        quizName,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black87,
                                                        ),
                                                        maxLines:
                                                            isMobile ? 2 : 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        '$percentage%',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 14,
                                                          color: Colors
                                                              .grey.shade600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 6,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: percentage >= 80
                                                        ? Colors.green.shade100
                                                        : percentage >= 60
                                                            ? Colors
                                                                .orange.shade100
                                                            : Colors
                                                                .red.shade100,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                  ),
                                                  child: Text(
                                                    '$marks/$total',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: percentage >= 80
                                                          ? Colors
                                                              .green.shade800
                                                          : percentage >= 60
                                                              ? Colors.orange
                                                                  .shade800
                                                              : Colors
                                                                  .red.shade800,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  double _calculateTotalMarks(dynamic internship) {
    double total = 0;
    if (internship['quizMarks'] != null &&
        (internship['quizMarks'] as List).isNotEmpty) {
      for (var quiz in internship['quizMarks']) {
        total += quiz['marks'] ?? 0;
      }
    }
    return total;
  }

  double _calculateTotalQuestions(dynamic internship) {
    double total = 0;
    if (internship['quizMarks'] != null &&
        (internship['quizMarks'] as List).isNotEmpty) {
      for (var quiz in internship['quizMarks']) {
        total += quiz['total_questions'] ?? 10;
      }
    }
    return total;
  }
}
