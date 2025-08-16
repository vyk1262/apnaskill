import 'package:flutter/material.dart';

Widget buildCertificateFeature(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.blue[100],
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check_circle, color: Colors.green[700], size: 18),
        const SizedBox(width: 8),
        Text(text),
      ],
    ),
  );
}
