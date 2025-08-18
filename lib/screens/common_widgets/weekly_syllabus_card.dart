import 'package:flutter/material.dart';

class WeekSyllabusCard extends StatelessWidget {
  final String title;
  final List<String> syllabusItems;
  final Color backgroundColor;

  const WeekSyllabusCard({
    super.key,
    required this.title,
    required this.syllabusItems,
    this.backgroundColor = const Color(0xFFFFF0EC), // light peachy
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Container(
        padding: const EdgeInsets.all(18),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.12),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 10,
              children: syllabusItems
                  .map(
                    (item) => Chip(
                      label: Text(item),
                      backgroundColor: Colors.white,
                      labelStyle: const TextStyle(color: Colors.black87),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
