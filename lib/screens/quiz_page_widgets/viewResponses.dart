import 'package:flutter/material.dart';

class ViewResponses extends StatelessWidget {
  final List<Map<String, dynamic>> quizData;
  final List<String?> userAnswers;
  final String quizName;

  ViewResponses(
      {required this.quizData,
      required this.userAnswers,
      required this.quizName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Responses - $quizName'),
      ),
      body: ListView.builder(
        itemCount: quizData.length,
        itemBuilder: (context, index) {
          final question = quizData[index];
          final userAnswer = userAnswers[index];
          final isCorrect = userAnswer == question['correct_answer'];

          return Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question['question'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  ...question['options'].entries.map((entry) {
                    final isSelected = userAnswer == entry.key;
                    final isCorrectAnswer =
                        question['correct_answer'] == entry.key;

                    return Container(
                      margin: EdgeInsets.only(bottom: 5),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? (isCorrect
                                ? Colors.green.withOpacity(0.5)
                                : Colors.red.withOpacity(0.5))
                            : (isCorrectAnswer
                                ? Colors.green.withOpacity(0.3)
                                : Colors.transparent),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        '${entry.key}: ${entry.value}',
                        style: TextStyle(
                          fontSize: 16,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  SizedBox(height: 10),
                  Text(
                    'Explanation: ${question['explanation']}',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
